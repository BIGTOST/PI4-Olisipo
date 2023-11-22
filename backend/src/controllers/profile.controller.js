const BD = require('../models/bd.models');
const profiles = require('../models/profiles.model');

const controller = {};

controller.list = async (req,res)=>{
    const data = await profiles.findAll()
    .then((data)=>{
        return data
    })
    .catch(error =>{
        console.log('Erro na listagem dos profiles: ' + error);
        return error;
    })
    res.json({
        success: true,
        data:data,
    })
}

controller.create = async (req,res)=>{
    const {profile} = req.body;
    const data = await profile.create({
        profile:profile,
        vis: true
    }).then((data)=>{
       return data
    }).catch(error=>{
        console.log('Error de criação do profile: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"Profile registrado",
        data:data
    });
}

controller.update = async (req,res)=>{
    const {id}=req.params;
    const {profile} = req.body;
    const data = await profile.update({
        profile:profile
    },{
        where:{idProfile:id}
    }).then((data)=>{
       return data
    }).catch(error=>{
        console.log('Error no updae do profile: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"Profile updated",
        data:data
    });
}

controller.delet = async (req,res)=>{
    const {id}=req.params;
    const data = await profile.update({
        vis: false
    },{
        where:{idProfile:id}
    }).then((data)=>{
       return data
    }).catch(error=>{
        console.log('Error no delete do profile: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"Profile deleted",
        data:data
    });
}



module.exports = controller;
