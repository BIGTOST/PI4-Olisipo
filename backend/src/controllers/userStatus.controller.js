const BD = require('../models/bd.models');
const userStatus = require('../models/userStatus.models');

const controller ={};

controller.create = async (req,res)=>{
    const {status} = req.body;
    const data = await userStatus.create({
        status:status,
        vis:true
    }).then((data)=>{
        return data;
    }).catch(error=>{
        console.log('Erro na craição do status do user: ' +error);
        return error
    });
    res.status(200).json({
        success:true,
        message:"userStatus Criado com sucesso",
        data:data
    });
}

controller.list = async (req,res)=>{
    const data = await userStatus.findAll()
    .then((data)=>{
        return data
    })
    .catch(error =>{
        return error;
    });
    res.json({
        success: true,
        data:data,
    });
}

controller.update = async (req,res)=>{
    const {id}= req.params;
    const {status} = req.body;
    const data = await userStatus.update({
        status:status,
    },{
        where:{idUserStatus:id}
    })
    .then((data)=>{
        return data;
    })
    .catch(error=>{
        console.log('Erro no Update do status do user: ' +error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"userStatus updated com sucesso",
        data:data
    })
}
controller.delete = async (req,res)=>{
    const {id}= req.params;
    const data = await userStatus.update({
        vis:false,
    },{
        where:{idUserStatus:id}
    })
    .then((data)=>{
        return data;
    })
    .catch(error=>{
        console.log('Erro no Delete do status do user: ' +error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"userStatus delete com sucesso",
        data:data
    })
}

module.exports = controller;