const BD = require('../models/bd.models');
const pNH = require('../models/pushNotificationHistory.models'); //? pushNotificationHistory => pNH


const controller = {};

controller.create = async (req,res)=>{
    const {desc, sendBy, sendTo} = req.body;
    const data = await pNH.create({
        sendAt:now(),
        desc:desc,
        vis:1,
        sendBy:sendBy,
        sendTo:sendTo
    }).then((data)=>{
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

controller.list = async (req,res)=>{
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