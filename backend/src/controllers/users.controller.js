//*packges necessarios
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');

//* tabelas base de dados
//?user part
const profile = require('../models/profiles.model');
const userStatus = require('../models/userStatus.models');
const users = require('../models/users.models');
const pushNotificationHistory = require('../models/pushNotificationHistory.models');
const userManager = require('../models/userManager.models');

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

//*ficheiros necessarios
const config = require('../config');
const BD = require('../models/bd.models');


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

controller.register = async (req,res) =>{
    const {name, email, phone, address, driver, password,profileUser} = req.body;
    const data = await users.create({
        name:name,
        email:email,
        phone:phone,
        address:address,
        driver:driver,
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
    })
    res.json({
        success: true,
        message:'³ E disse o programador: Haja Base de dados; e houve Base de dados'
    })
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
                    {email: req.body.email}, 
                    config.jwtSecret,
                    {expiresIn: '4h'}
                );
                res.cookie('Authorization', "bearer " + token);
                res.json({
                    success:true,
                    message:'Autenticação realizada com sucesso!',
                    token:token
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

module.exports = controller;


