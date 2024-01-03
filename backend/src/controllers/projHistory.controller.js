const projHistory = require('../models/projHistory.models');

const controller ={};

controller.create = async (req,res)=>{
    const {descProj, idPartner, idUser} = req.body;
    const data = await projHistory.create({
        descProj:descProj,
        vis:1,
        idPartner:idPartner,
        idUser:idUser
    })
    .then((data)=>{
        return data
     }).catch(error=>{
         console.log('Error de criação do projHistory: ' + error);
         return error
     })
     res.status(200).json({
         success:true,
         message:"projHistory registrado",
         data:data
     });
}

controller.listAll = async (req,res)=>{
    const data = await projHistory.findAll()
    .then((data)=>{
        return data
     }).catch(error=>{
         console.log('Error de list do projHistory: ' + error);
         return error
     })
     res.status(200).json({
         success:true,
         message:"projHistory listado",
         data:data
     });
}
controller.list = async (req,res)=>{
    const id = req.user.id;
    const data = await projHistory.findAll({where:{idUser:id}})
    .then((data)=>{
        return data
     }).catch(error=>{
         console.log('Error de list do projHistory: ' + error);
         return error
     })
     res.status(200).json({
         success:true,
         message:"projHistory listado",
         data:data
     });
}
controller.update = async (req,res)=>{
    const {id} = req.params;
    const {descProj, idPartner, idUser} = req.body;
    const data = await projHistory.update({
        descProj:descProj,
        idPartner:idPartner,
        idUser:idUser
    },{
        where:{idProjHistory:id}
    })
    .then((data)=>{
        return data
     }).catch(error=>{
         console.log('Error de update do projHistory: ' + error);
         return error
     })
     res.status(200).json({
         success:true,
         message:"projHistory updated",
         data:data
     });
}

controller.delete = async (req,res)=>{
    const {id} = req.params;

    const data = await projHistory.update({
        vis:0
    },{
        where:{idProjHistory:id}
    })
    .then((data)=>{
        return data
     }).catch(error=>{
         console.log('Error de delete do projHistory: ' + error);
         return error
     })
     res.status(200).json({
         success:true,
         message:"projHistory deleted",
         data:data
     });
}

module.exports = controller;