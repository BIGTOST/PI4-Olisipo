const partner = require('../models/partners.models');

const controller = {};


controller.create = async (req,res) =>{
    const {nome, imgPath} = req.body;

    const data = await partner.create({
        nome:nome,
        imgPath:imgPath,
        vis:1
    }).then((data)=>{
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
controller.update = async (req,res) =>{
    const {nome, imgPath} = req.body;
    const {id} = req.params;
    const data = await partner.create({
        nome:nome,
        imgPath:imgPath,
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
    const data = await partner.create({
        nome:nome,
        imgPath:imgPath,
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