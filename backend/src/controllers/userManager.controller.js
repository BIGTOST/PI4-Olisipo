const userManager = require('../models/userManager.models');

const controller = {};

controller.create = async (req,res) =>{
    const {idUser, idManager}= req.body;

    const data = await pNH.create({
        idUser:idUser,
        idManager:idManager,
        vis:1,
    }).then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error de criação do userManager: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"userManager registrado",
        data:data
    });
}

controller.list = async (req,res) =>{
    const data = await userManager.findAll()
    .then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error na listagem dos User Managers: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"User Managers listadas",
        data:data
    });
}

controller.update = async (req,res) =>{
    const {id} = req.params;
    const {idUser, idManager}= req.body;

    const data = await pNH.update({
        idUser:idUser,
        idManager:idManager,

    },{
        where:{idUserManger:id}
    }).then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error de update do userManager: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"userManager registrado",
        data:data
    });
}

controller.delete = async (req,res) =>{
    const {id} = req.params;

    const data = await pNH.update({
        vis:0

    },{
        where:{idUserManger:id}
    }).then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error de deleted do userManager: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"userManager deleted",
        data:data
    });
}

module.exports = controller