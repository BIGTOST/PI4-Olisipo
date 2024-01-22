//*packges necessarios
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const Sequelize = require('sequelize');
const generatoPass = require('generate-password');
const dotenv = require('dotenv');
const nodeMailer = require('nodemailer');


//* tabelas base de dados
//?user part
const profile = require('../models/profiles.model');
const userStatus = require('../models/userStatus.models');
const users = require('../models/users.models');
const pushNotificationHistory = require('../models/pushNotificationHistory.models');
//const userManager = require('../models/userManager.models');

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
const calendarEnventType = require('../models/calendarEventType.models');
const calendar = require('../models/calendar.models');

//? Logs
const logs = require('../models/logs.models');

//*ficheiros necessarios
const config = require('../config');
const BD = require('../models/bd.models');
const middleware = require('../middleware');
const path = require('path');



//* sincronização com a base de dados
BD.sync()

dotenv.config({path:'.env'});


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
            return data;
        })
        .catch(err=>{
            console.log('Erro:'+ err);
            return err;
        });
        res.status(201).json({
            success: true,
            message:'³ E disse o programador: Haja Users; e user então ouve'
        })
    }

   
}

controller.login = async (req, res)=>{
    let email, password;
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
                    {   id:user.idUser,
                        email: req.body.email
                    },
                    config.jwtSecret,
                    {expiresIn: '4h'}
                );
                //res.cookie('Authorization', "bearer " + token);
                res.json({
                    success:true,
                    message:'Autenticação realizada com sucesso!',
                    token:token,
                });
               
            }
            else{
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

controller.update = async (req,res)=>{
    const id = req.user.id;
    console.log(id);
    const {name, email, phone, address, driver, profileUser} = req.body;
    const data = await users.update({
        name:name,
        email:email,
        phone:phone,
        address:address,
        driver:driver,
        profileUser:profileUser,
    },{ 
        where: {idUser: id}
    }).then((data)=>{
        return data;
    })
    .catch(error=>{
        return error;
    })
    res.status(200).json({
        success: true,
        data:data,
        message:"Update deu certo"
    });
}

controller.updateThis = async (req,res)=>{
    const idAdmin = req.user.id;
    const {id} = req.params;
    console.log(id);
    const {name, email, phone, address, driver, profileUser} = req.body;
    const data = await users.update({
        name:name,
        email:email,
        phone:phone,
        address:address,
        driver:driver,
        profileUser:profileUser,
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
    //console.log(user);
    //console.log(user.password);
    //console.log(newPassword);
    //console.log(encrypted)

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
                return data
            })
            .catch(err=>{
                return err
            })
            res.status(200).json({
                success: true,
                message:' password updated'
            })
            // res.json({
            //     data:user,
            //     match: passMatch,
            //     enc:encrypted,
            //     log:dec,
            //     logs:log
            // })
        }
    }

    // !descrição do problema
    // !1º verificar se a password atual é realmente a correta
    //     !1.1 para isso faço um findAll com o where  do id e armazeno em uma variavel
    //     !ustilizo o compareSync do jwt para ver se as password batem const isMatch = bcrypt.compareSync(password, user.password);
    //         !se der match parssar para a proxima fase, se não retornar um json com erro
    //     !2ª comparar newPassword e confirmNewPassword
    //         ! se não baterem retornar um json a informar que as novas senhas não batem
    //         ! se baterem encryptar a password e dar update
        

}

controller.changeThisPassword = async (req,res)=>{
    const {id} = req.params;
    const {newPassword, confirmNewPassword} = req.body;
    const encrypted = await bcrypt.hash(newPassword, 10)
    .then(hash=>{
        return hash
    });

    let user = await users.findOne({where:{idUser:id}});
    //console.log(user);
    //console.log(user.password);
    //console.log(newPassword);
    //console.log(encrypted)

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
                return data
            })
            .catch(err=>{
                return err
            })
            res.status(200).json({
                success: true,
                message:' password updated'
            })
            // res.json({
            //     data:user,
            //     match: passMatch,
            //     enc:encrypted,
            //     log:dec,
            //     logs:log
            // })
        }
    }

    // !descrição do problema
    // !1º verificar se a password atual é realmente a correta
    //     !1.1 para isso faço um findAll com o where  do id e armazeno em uma variavel
    //     !ustilizo o compareSync do jwt para ver se as password batem const isMatch = bcrypt.compareSync(password, user.password);
    //         !se der match parssar para a proxima fase, se não retornar um json com erro
    //     !2ª comparar newPassword e confirmNewPassword
    //         ! se não baterem retornar um json a informar que as novas senhas não batem
    //         ! se baterem encryptar a password e dar update
        

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
                return data
            })
            .catch(err=>{
                return err
            })
            res.status(200).json({
                success: true,
                message:' password updated'
            })
            
            // res.json({
            //     data:user,
            //     match: passMatch,
            //     enc:encrypted,
            //     log:dec,
            //     logs:log
            // })
        }
           
    }
    
    // !descrição do problema
    // !1º verificar se a password atual é realmente a correta
    //     !1.1 para isso faço um findAll com o where  do id e armazeno em uma variavel
    //     !ustilizo o compareSync do jwt para ver se as password batem const isMatch = bcrypt.compareSync(password, user.password);
    //         !se der match parssar para a proxima fase, se não retornar um json com erro
    //     !2ª comparar newPassword e confirmNewPassword
    //         ! se não baterem retornar um json a informar que as novas senhas não batem
    //         ! se baterem encryptar a password e dar update
        

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
        res.status(200).json({
            message:'Será enviado para seu email um codigo para alterar a sua password',
            token: token

        })
       
    }

    //! 1º verificar se email exist
    //! 2º gerar uma palavra pass
    //! 3º enviar a passa por email
    //! 4º generate a temporari token

}

controller.verifycationQuery = async(req, res)=>{
    const {email} = req.body;
    const textMail = `
        <h1>Email da Plataforma Olisipo</h1>
        <p>Link para verificação do email:</p>
        <a href='http://mktiagoandre.ddns.net:8080/user/verification/${email}'><p><b>cverificar</b></p></a>
    `;

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
    .then(console.log('Messagem enviada ' + true))
    .catch(e=>console.log(e));
    res.status(200).json({
        message:"email de verificação enviado"
    })
}

controller.verification = async (req, res)=>{
    console.log('dentro do verification');
    const {email} = req.params;
    const data = await users.update({
        statusUser:3
    },
    {where:{email:email}})
    .then(console.log('Messagem enviada ' + true))
    .catch(e=>console.log(e));
    res.status(200).send(`
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Verificação de Email - Portal do Colaborador Olisiop</title>
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


