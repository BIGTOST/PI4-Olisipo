//*packges necessarios
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const Sequelize = require('sequelize');
const generatoPass = require('generate-password');
const twilio = require('twilio');
const dotenv = require('dotenv');


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
    res.json({
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
    res.json({
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
            message:'³ E disse o programador: Haja Base de dados; e houve Base de dados'
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
            // let dec = jwt.sign(
            //     {  
            //         ActionType:"Change PassWord",
            //         oldData:user.password,
            //         newData:encrypted
            //     },
            //     config.jwtSecret,
            // ).toString()

            // // console.log(dec +"  aaa");
            // const log = await logs.create({
            //     userId:id,
            //     createdAt: Sequelize.fn('NOW'),
            //     desc: dec
            // });
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
    const {email} = req.body
    const emailExist = await users.count({where:{email:email}}).then(count=>{if(count!=0){return true}else{return false}});
    //console.log(emailExist);

    if(!emailExist){
        res.status(404).json({
            message:'o email introduzino não está registrado'
        })
    }else{
        let newPassword = generatoPass.generate({
            length:10,
            numbers: true
        });
        console.log(newPassword);

        const encrypted = await bcrypt.hash(newPassword, 10)
        .then(hash=>{
            return hash
        });

        console.log(encrypted);
        res.status(200).json({
            message:'success'
        })

        const data = await users.findAll(
            {where: {email:email}}
        )
        .then((data)=>{
            return data
        })
        .catch(err=>{
            return err
        })
        console.log(data.user.dataValues.phone);

        // const clinte = twilio(process.env.TWILIO_SID, process.env.TWILIO_AUTH_TOKEN);
        // client.message.create({
        //     body:'Olá aqui está a sua nova password: '+newPassword,
        //     from:'+351 999999999',
        //     to: data.phone 
        // })
    }

    //! 1º verificar se email exist
    //! 2º gerar uma palavra pass
    //! 3º enviar a passa por email

}

module.exports = controller;


