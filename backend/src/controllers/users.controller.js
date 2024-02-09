//*packges necessarios
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const Sequelize = require('sequelize');
const generatoPass = require('generate-password');
const nodeMailer = require('nodemailer');

const log = require('./logs.controller');


//* tabelas base de dados
//?user part
const profile = require('../models/profiles.model');
const userStatus = require('../models/userStatus.models');
const users = require('../models/users.models');
const pushNotificationHistory = require('../models/pushNotificationHistory.models');

//?project part
const docs = require('../models/docs.moduls');
const partner = require('../models/partners.models');
const projHistory = require('../models/projHistory.models')

//?news part
const newsState = require('../models/newsState.model');
const newsType = require('../models/newsType.models');
const news = require('../models/news.models');

//?calendar part
const calendarStatus = require('../models/calendarStatus.models');
const calendarEvent = require('../models/calendarEvent.models');
const calendar = require('../models/calendar.models');

//? Logs
const logsRoute = require('../models/logs.models');

//*ficheiros necessarios
const config = require('../config');
const BD = require('../models/bd.models');
const middleware = require('../middleware');
const path = require('path');



//* sincronização com a base de dados
BD.sync()


//*criação dos controller para os dados da tabela user
const controller = {};

controller.list = async (req, res)=>{
    const data  = await users.findAll()
    .then(function(data){
        return data;
        
    })
    .catch( error =>{
        return error;
    });
    res.status(200).json({
        success: true,
        data:data
    });
}

controller.encontrar = async (req, res)=>{
    const id = req.user.id;
    const data  = await users.findAll({where:{idUser:id}})
    .then(function(data){
        return data;
        
    })
    .catch( error =>{
        return error;
    });
    res.status(200).json({
        success: true,
        data:data
    });
}

controller.encontrarThis = async (req, res)=>{
    const {id} = req.params;
    const data  = await users.findAll({where:{idUser:id}})
    .then(function(data){
        return data;
        
    })
    .catch( error =>{
        return error;
    });
    res.status(200).json({
        success: true,
        data:data
    });
}

controller.register = async (req,res) =>{ 
    const {name, email,password,profileUser} = req.body;
    let emailExist= false;
    //*verificação se o email existe
    emailExist = await users.count({where:{email:email}}).then(count=>{if(count!=0){return true}else{return false}});
    console.log(emailExist);

    if(emailExist){
        res.status(409).json({
            message:"o email que foi enviado já existe"
        })
    }else{
        const data = await users.create({
            name:name,
            email:email,
            password:password,
            vis: true,
            profileUser:profileUser,
            statusUser: 1
        })
        .then(function(data){

            log.createLog('User de nome: ' + name+ 'registrado de forma independente com o email: '+ email + '.' );
            res.status(201).json({
                success: true,
                message:'³ E disse o programador: Haja Users; e user então ouve'
            })
            return data;
        })
        .catch(err=>{
            
            log.createLog('Tentativa falha de registro do User de nome: ' + name+ 'com o email: '+ email + ', error log:' +err+'.' );
            res.status(400).json({
                success: false,
                message:'Erro na criação do user tente novamente mais tarde'
            })
            console.log('Erro:'+ err);
            return err;
        });
        
    }

   
}

controller.registerByAdmin = async (req,res) =>{ 
    const admId = req.user.id
    let adminData = await users.findOne({where:{idUser:admId}});
    if(adminData.profileUser === 0){
        const {name,email,password,profileUser} = req.body;
        let emailExist= false;
        //*verificação se o email existe
        emailExist = await users.count({where:{email:email}}).then(count=>{if(count!=0){return true}else{return false}});
        console.log(emailExist);

        if(emailExist){
            res.status(409).json({
                message:"o email que foi enviado já existe"
            })
        }else{
            const data = await users.create({
                name:name,
                email:email,
                password:password,
                vis: true,
                profileUser:profileUser,
                statusUser: 1
            })
            .then(function(data){

                log.createLog('User de nome: ' + name+ 'registrado de forma independente com o email: '+ email + '.' );
                res.status(201).json({
                    success: true,
                    message:'³ E disse o programador: Haja Users; e user então ouve'
                });
                return data;
            })
            .catch(err=>{
                
                log.createLog('Tentativa falha de registro do User de nome: ' + name+ 'com o email: '+ email + ', error log:' +err+'.' );
                res.status(400).json({
                    success: false,
                    message:'Erro na criação do user tente novamente mais tarde'
                })
                console.log('Erro:'+ err);
                return err;
            });
            
        }
    }else{
        res.status(401).json({
            success:false,
            message:'ação não autorizada'
        });
    }
}

controller.login = async (req, res)=>{
    let email, password;
    if(email != '' && password != ''){
        if(req.body.email && req.body.password){
            email = req.body.email;
            console.log(email);
            password = req.body.password;
            console.log(password);
        }
        let user = await users.findOne({where:{email:email}})
        .then(function(data){
            return data;
        })
        .catch(error=>{
            console.log('Error:' + error);
            return error;
        })
    
        if(password === null || typeof password === 'undefined'){
            res.status(403).json({
                success: false,
                message: 'Falta-te conhecimento do segredo'
            })
        }
        else{
            if(req.body.email && req.body.email && user){
                const isMatch = bcrypt.compareSync(password, user.password);
                if(req.body.email=== user.email && isMatch){
                
                    let token = jwt.sign(
                        {   
                            id:user.idUser,
                            email: req.body.email,
                            profile: user.profile
                        },
                        config.jwtSecret,
                        {expiresIn: '4h'}
                    );
                    log.createLog('logIn da conta do utlizador: ' + user.name + ', de id: ' + user.idUser + ', de email: ' + user.email+'.', user.idUser);
                    //res.cookie('Authorization', "bearer " + token);
                    res.status(201).json({
                        success:true,
                        message:'Autenticação realizada com sucesso!',
                        token:token,
                        profile: user.profile
                    });
                   
                }
                else{
                    log.createLog('Tentativa mal sucedida de logIn na conta do utlizador: ' + user.name + ', de id: ' + user.idUser + ', de email: ' + user.email+'.', user.idUser);
                    res.status(403).json({
                        success: false,
                        message:'²⁴ E havendo deslogado o user, o programador pôs IFs e Elses ao oriente do logIn da Aplicação, e um token inflamado que autorizava ao redor, para guardar o caminho da informação'
                    })
                }
            }else{
                res.status(400).json({
                    success: false,
                    message: 'O programador não responde ao seu pedido, está ocupado com outro filho, tente mais tarde'
                });
            }
        }
    }
    else{
        res.status(403).json({
            success: false,
            message: 'Faltam dados'
        })
    }
}

controller.update = async (req,res)=>{
    const id = req.user.id;
    console.log(id);
    //* dados antigos do user para fins de log
    let user = await users.findOne({where:{idUser:id}});
    
    const {name, email, phone, address, driver, profileUser} = req.body;

    const data = await users.update(
        {
            name:name,
            email:email,
            phone:phone,
            address:address,
            driver:driver,
            profileUser:profileUser,
        },
        { 
            where: {idUser: id}
        }
    )
    .then((data)=>{
        log.createLog(
            'Dados do user de ID:' + id +
            'atualizado pelo administrador de id: '+idAdmin+
            ', dados antigos, nome:'+user.name+' email:'+ user.email+', phone:' +user.phone+' ,address:'+user.address + ', driver status:' + user.driver +', profile status: ' +user.profileUser + 
            ', dados novos, nome:'+ name + ', email:' + email+', phone:' + phone + ' ,address:'+ address + ', driver status:' + driver +', profile status: ' + profileUser + '.',
            id
        );
        res.status(200).json({
            success: true,
            data:data,
            message:"Update deu certo"
        });
        return data;
    })
    .catch(error=>{
        res.status(404).json({
            message:'ocorreu algum erro no update da informação',
            data:error
        })
        log.createLog(
            'Erro no update dos dados do do user de ID:' + id +
            ' Ação executada pelo administrador de id: '+idAdmin+
            ', dados antigos, nome:'+user.name+' email:'+ user.email+', phone:' +user.phone+' ,address:'+user.address + ', driver status:' + user.driver +', profile status: ' +user.profileUser + 
            ', dados novos, nome:'+ name + ', email:' + email+', phone:' + phone + ' ,address:'+ address + ', driver status:' + driver +', profile status: ' + profileUser + 
            ' error log: '+error+'.',
            id
        );
        return error;
    })
}

controller.updateManager = async (req,res)=>{
    //* quem está a fazer está ação
    const idAdmin = req.user.id;

    //* quem terá seus dados alterados
    const {id} = req.params;

    //*dados de quem está a realizar a ação para fins de logs
    let user = await users.findOne({where:{idUser:idAdmin}});

    let userAlter = await users.findOne({where:{idUser:id}});
    //* dados do antigo manager do utilizidar que está a ser alterado para fins de logs
    let managerOld = await users.findOne({where:{idUser:user.userAlter}});
    
    const {manager} = req.body;
    //* dados do novo manager do utilizidar que está a ser alterado para fins de logs
    let managerNew = await users.findOne({where:{idUser:manager}})

    //* verificação se quem está arealiza a ação é um utilizador de grau adminsitrado
    if(user.profileUser === 0){
        const data = await users.update({
            manager:manager
        },{ 
            where: {idUser: id}
        }).then((data)=>{
            log.createLog(
                'Manager do user de ID:' + id+' de nome: ' + userAlter.name + 'atualizado pelo administrador de id: '+ idAdmin + ' de nome:'+user.name+', ' +
                ' antigo amanager: ' + managerOld.name + ', de id: ' +managerOld.idUser+
                ', para Nova data: '+ managerNew.name + ', de id: ' + manager + '.',
                id
            );
            return data;
        })
        .catch(error=>{
            return error;
        })
        res.status(200).json({
            success: true,
            data:data,
            message:"Update de manager correu corretamente"
        });
    }else{
        res.status(406).json({
            success: false,
            message:"somente um utilizador de grau administrador pode executar esta função, "
        });
    }
}

controller.updateThis = async (req,res)=>{
    
    const idAdmin = req.user.id;
    
    const {id} = req.params;

    console.log(id);

    const {name, email, phone, address, driver, profileUser, manager, states} = req.body;
    let user = await users.findOne({where:{idUser:id}});
    let admir = await users.findOne({where:{idUser:idAdmin}});
    if(admir.profileUser === 0){
        const data = await users.update({
            name:name,
            email:email,
            phone:phone,
            address:address,
            driver:driver,
            statusUser:states,
            profileUser:profileUser,
            manager:manager
        },{ 
            where: {idUser: id}
        }).then((data)=>{
            log.createLog(
                'Dados do user de ID:' + id +
                'atualizado pelo administrador de id: '+idAdmin+
                ', dados antigos, nome:'+user.name+' email:'+ user.email+', phone:' +user.phone+' ,address:'+user.address + ', driver status:' + user.driver +', profile: ' +user.profileUser + 'manager: '+user.manager+ ' status:' + user.statusUser+
                ', dados novos, nome:'+ name + ', email:' + email+', phone:' + phone + ' ,address:'+ address + ', driver status:' + driver +', profile status: ' + profileUser + ' manager: '+ manager+' statusUser: ' +states+'.',
                id);
            return data;
        })
        .catch(error=>{
            return error;
        })
        res.json({
            success: true,
            data:data,
            message:"Update deu certo"
        });
    }
    else{
        res.status(406).json({
            success: false,
            message:"somente um utilizador de grau administrador pode executar esta função, "
        });
    }
}

controller.delete= async (req,res)=>{
    //id vindo do token
    const id = req.user.id;
    console.log(id);
    const data = await users.update({
        vis:false
    },{ 
        where: {idUser: id}
    }).then((data)=>{
        return data;
    })
    .catch(error=>{
        return error;
    })
    res.json({
        success: true,
        data:data,
        message:"Update deu certo"
    });
}

controller.changePassword = async (req,res)=>{
    const id = req.user.id;
    const {actualPassword, newPassword, confirmNewPassword} = req.body;
    const encrypted = await bcrypt.hash(newPassword, 10)
    .then(hash=>{
        return hash
    });

    let user = await users.findOne({where:{idUser:id}});


    const passMatch = bcrypt.compareSync(actualPassword, user.password);
    if(!passMatch){
        res.status(403).json({
            success:false,
            message:"Password Incorreta"
        });
    }else{
        //?Checagem se a nova password e a confirm nova password work
        if(!newPassword===confirmNewPassword){
            res.status(406).json({
                message:"as novas passwords não consdizem"
            })
        }else{
            const data = await users.update({
                password: encrypted
            },{
                where:{idUser:id}
            }).then((data)=>{
                log.createLog('O user: '+user.name+'de id: ' +user.idUser + 'alterou a password', id);
                return data
            })
            .catch(err=>{
                return err
            })
            res.status(200).json({
                success: true,
                message:' password updated'
            })
        }
    }
}

controller.changeThisPassword = async (req,res)=>{
    const userAdmin = req.user.id;
    const {id} = req.params;
    
    const {newPassword, confirmNewPassword} = req.body;
    const encrypted = await bcrypt.hash(newPassword, 10)
    .then(hash=>{
        return hash
    });

    let user = await users.findOne({where:{idUser:id}});
    let userAdminData = await users.findOne({where:{idUser:userAdmin}});

    const passMatch = bcrypt.compareSync(actualPassword, user.password);
    if(!passMatch){
        res.status(403).json({
            success:false,
            message:"Password Incorreta"
        });
    }else{
        if(userAdminData.profileUser === 0){
            //?Checagem se a nova password e a confirm nova password work
            if(!newPassword===confirmNewPassword){
                res.status(406).json({
                    message:"as novas passwords não consdizem"
                })
            }else{
                const data = await users.update({
                    password: encrypted
                },{
                    where:{idUser:id}
                }).then((data)=>{
                    
                    return data
                })
                .catch(err=>{
                    return err
                })
                res.status(200).json({
                    success: true,
                    message:' password updated'
                })
            }
        }else{
            log.createLog('tentativa de alteração da password do user: '+user.name+', de id: '+ id+', pelo utilizador:' + userAdminData.name+', de id: '+userAdminData.idUser, userAdmin);
            res.status(403).json({
                message:'Somente utilizadores de cargo administrador ou o proprio dono da conta podem exercer a função de alterar password'
            });
        }
    }
}

controller.recoverPasswordQuery = async (req,res)=>{
    const {mail} = req.body
    const emailExist = await users.count({where:{email:mail}}).then(count=>{if(count!=0){return true}else{return false}});

    if(!emailExist){
        res.status(404).json({
            message:'o email introduzino não está registrado'
        })
    }else{

        //* Criação do codigo temporario
        let newPassword = generatoPass.generate({
            length:10,
            numbers: true
        });
        //console.log(newPassword);

        const encrypted = await bcrypt.hash(newPassword, 10)
        .then(hash=>{
            return hash
        });

        await users.update({
            password:encrypted
        },{
            where:{email:mail}
        })
        .then(console.log('password Updated'))
        .catch(console.log('error'))

        //console.log(encrypted);
        const textMail = `
            <h1>Email da Plataforma Olisipo</h1>
            <p>Codigo para alteração de passord:</p>
            <p><b>${newPassword}</b></p>
        `;

        const email = await users.findAll(
            {
                attributes:['email'],
                where: {email:mail}
            }
        )
        .then((data) => {
            const email = data.map(user => user.dataValues.email);
            console.log(email);
            return email;
        })
        .catch(err=>{
            return err
        })

        const transporter = nodeMailer.createTransport({
            service:'gmail',
            host: "smtp.gmail.com",
            port: 465,
            secure:true,
            auth: {
              user: "testeAPiOlp@gmail.com",
              pass: "qcvq muvi fiap vfsq",
            },
          });
    
        const info = await transporter.sendMail({
            from:{
                name: 'Portal do Colaborador Olisipo',
                address:'testeAPiOlp@gmail.com',
            },
            to:email,
            subject:'Password Recover',
            html:textMail
        })
        .then(console.log('Messagem enviada ' + true))
        .catch(e=>console.log(e));
        console.log(textMail);
        //*token temporario
        let token = jwt.sign(
            {   
                email: email
            },
            config.jwtSecret,
            {
                expiresIn: '20m'
            }
        );
        log.createLog('solicitação de recuperação da password pelo user: ' + user.name, user.id)
        res.status(200).json({
            message:'Será enviado para seu email um codigo para alterar a sua password',
            token: token

        })
       
    }
}

controller.recoverPassword = async (req,res)=>{
    const email = req.user.email;
    const {codigo, newPassword, confirmNewPassword} = req.body;
    const encrypted = await bcrypt.hash(newPassword, 10)
    .then(hash=>{
        return hash
    });

    let user = await users.findOne({where:{email:email}});
    
    const passMatch = bcrypt.compareSync(codigo, user.password);
    if(!passMatch){
        res.status(403).json({
            success:false,
            message:"Password Incorreta"
        });
    }else{
        //?Checagem se a nova password e a confirm nova password work
        if(!newPassword===confirmNewPassword){
            res.status(406).json({
                message:"as novas passwords não consdizem"
            })
        }else{
        
            const data = await users.update({
                password: encrypted
            },{
                where:{email:email}
            }).then((data)=>{
                log.createLog('Password do utilizador: ' +user.name+ ' de id: '+user.idUser + ' alterada atravez do password Recovery.', user.idUser);
                return data
            })
            .catch(err=>{
                return err
            })
            
            res.status(200).json({
                success: true,
                message:' password updated'
            })
        }
    }
}

controller.verifycationQuery = async(req, res)=>{
    const {email} = req.body;
    const textMail = `
        <h1>Email da Plataforma Olisipo</h1>
        <p>Link para verificação do email:</p>
        <a href='https://backend-w7pc.onrender.com/user/verification/${email}'><p><b>verificar</b></p></a>
    `;
    // const textMail = `
    //     <h1>Email da Plataforma Olisipo</h1>
    //     <p>Link para verificação do email:</p>
    //     <a href='http://mktiagoandre.ddns.net:8080/user/verification/${email}'><p><b>verificar</b></p></a>
    // `;

    const transporter = nodeMailer.createTransport({
        service:'gmail',
        host: "smtp.gmail.com",
        port: 465,
        secure:true,
        auth: {
        user: "testeAPiOlp@gmail.com",
        pass: "qcvq muvi fiap vfsq",
        },
    });

    const info = await transporter.sendMail({
        from:{
            name: 'Portal do Colaborador Olisipo<Não responder este email>',
            address:'testeAPiOlp@gmail.com',
        },
        to:email,
        subject: 'Verificação de Email',
        html:textMail
    })
    .then(()=>{
        console.log('Messagem enviada ' + true)
        log.createLog('Solicitação de verificação de email enviada para o email: ' +email);
    })
    .catch(e=>console.log(e));
    res.status(200).json({
        message:"email de verificação enviado"
    })
}

controller.verification = async (req, res)=>{
    console.log('dentro do verification');
    const {email} = req.params;
    const user = await users.findOne({where:{email:email}});
    const data = await users.update({
        statusUser:3
    },
    {where:{email:email}})
    .then(()=>{
        console.log('Messagem enviada ' + true);
        log.createLog('verificação do email:'+email+' realizada com sucesso', user.idUser);
    })
    .catch(e=>console.log(e));
    res.status(200).send(`
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Verificação de Email - Portal do Colaborador Olisipo</title>
            <style>
                body {
                    font-family: 'Calibri', sans-serif;
                    background-color: #000; /* Set the background color to Pantone® Process Black C */
                    margin: 0;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    height: 100vh;
                }

                .box {
                    background-color: #fff;
                    color: #000; /* Set the text color to Pantone® Process Black C */
                    border: 1px solid #ddd;
                    border-radius: 8px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    width: 400px;
                    padding: 30px;
                    text-align: center;
                }

                h2 {
                    font-size: 18px;
                    font-weight: bold;
                    margin-bottom: 20px;
                }

                p {
                    font-size: 14px;
                    margin-bottom: 20px;
                }
            </style>
        </head>
        <body>
            <div class="box">
                <h2>Verificação de Email - Portal do Colaborador Olisiop</h2>
                <p>O seu email foi verificado com sucesso. Agora poderá ter acesso à aplicação.</p>
            </div>
        </body>
        </html>
    `);
}


module.exports = controller;


