const logs = require('./logs.controller')
const users = require('../models/users.models');
const op = require('sequelize');
const pNH = require('../models/pushNotificationHistory.models'); //? pushNotificationHistory => pNH


const controller = {};

controller.create = async (req,res)=>{
    const idSender = req.user.id
    const {desc, sendTo} = req.body;

    let reciver = await users.findOne({where:{idUser:sendTo}});
    let sender = await users.findOne({where:{idUser:idSender}});

    const data = await pNH.create({
        desc:desc,
        vis:1,
        sendBy:idSender,
        sendTo:sendTo
    }).then((data)=>{
        logs.createLog(
            'o Adminsitrador:' + sender.name+
            ' enviou a seguinte notificação: ' + desc +
            ' para o utilizador de nome:' + reciver.name + ' com o id de ' + reciver.idUser + '.',
            idSender
        )
        return data
    }).catch(error=>{
        console.log('Error de criação do pushNotificationHistory: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"pushNotificationHistory registrado",
        data:data
    });
}

controller.listTudo = async (req,res)=>{
    const data = await pNH.findAll()
    .then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error na listagem das pushNotificationHistory: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"pushNotificationHistory listadas",
        data:data
    });
}

controller.list = async (req,res)=>{
    const id = req.user.id;
    const data = await pNH.findAll(
        {
            where:{[op.or]:[
                {sendBy:id},
                {sendTo:id}
            ]}
        }
    )
    .then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error na listagem das pushNotificationHistory: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"pushNotificationHistory listadas",
        data:data
    });
}

controller.update = async (req,res)=>{
    const {id} = req.params;
    const {desc, sendBy, sendTo} = req.body;
    const data = await pNH.updata({
        desc:desc,
        sendBy:sendBy,
        sendTo:sendTo
    },{
        where:{idpushNotificationHistory:id}
    }).then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error de update do pushNotificationHistory: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"pushNotificationHistory registrado",
        data:data
    });
}

controller.delete = async (req,res)=>{
    const {id} = req.params;
    const data = await pNH.updata({
        vis:0
    },{
        where:{idpushNotificationHistory:id}
    }).then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error de delete do pushNotificationHistory: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"pushNotificationHistory delete",
        data:data
    });
}


module.exports = controller