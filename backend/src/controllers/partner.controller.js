const partner = require('../models/partners.models');
const logs = require('./logs.controller');

const controller = {};


controller.create = async (req,res) =>{
    const idAdmin = req.user.id;
    const {nome} = req.body;

    const data = await partner.create({
        nome:nome,
        imgPath:imgPath,
        vis:1
    }).then((data)=>{
        logs.createLog('Um novo partner foi registrado: ' + nome +', criado pelo utilizador de id: '+idAdmin+'.',idAdmin );
        return data
     }).catch(error=>{
         console.log('Error de criação do partner: ' + error);
         return error
     })
     res.status(200).json({
         success:true,
         message:"Partner registrado",
         data:data
     });
}
controller.list = async (req,res) =>{
    const data = await partner.findAll()
    .then((data)=>{
        return data
     }).catch(error=>{
         console.log('Error de listagem do partner: ' + error);
         return error
     })
     res.status(200).json({
         success:true,
         message:"Partner Listado",
         data:data
     });
}

controller.findThisPartner = async (req,res) =>{
    const {id} = req.params
    const data = await partner.findAll({where:{idPartner:id}})
    .then((data)=>{
        return data
     }).catch(error=>{
         console.log('Error de listagem do partner: ' + error);
         return error
     })
     res.status(200).json({
         success:true,
         message:"Partner Listado",
         data:data
     });
}
controller.update = async (req,res) =>{
    const idAdmin = req.user.id;
    const {nome} = req.body;
    const {id} = req.params;
    const data = await partner.update({
        nome:nome,
    },{
        where:{idPartner:id}
    }).then((data)=>{
        return data
     }).catch(error=>{
         console.log('Error de update do partner: ' + error);
         return error
     })
     res.status(200).json({
         success:true,
         message:"Partner updated",
         data:data
     });
}
controller.delete = async (req,res) =>{
    const {id} = req.params;
    const data = await partner.delete({
        vis:0
    },{
        where:{idPartner:id}
    }).then((data)=>{
        return data
     }).catch(error=>{
         console.log('Error de update do partner: ' + error);
         return error
     })
     res.status(200).json({
         success:true,
         message:"Partner updated",
         data:data
     });
}

module.exports = controller