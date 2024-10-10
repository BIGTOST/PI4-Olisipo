const { json } = require('sequelize');
const BD = require('../models/bd.models');
const newsStates = require('../models/newsState.model');

const controller = {};

controller.create = async (req,res)=>{
    const {status} = req.body;
    const data = await newsStates.create({
        status: status,
        vis: true
    }).then((data)=>{
        return data
    })
    .catch(erro=>{
        console.log('Error na criação do newsStatus: ' + erro);
        return erro
    });
    res.json({
        success:true,
        message: 'newsStatus criado com sucesso',
        data:data
    })
}

controller.list = async (req,res)=>{
    const data = await newsStates.findAll()
    .then((data)=>{
        return data 
    })
    .catch(erro=>{
        console.log('Error na listage do newsStatus: ' + erro);
        return erro
    });
    res.json({
        success:true,
        data:data
    })
}

controller.update = async (req,res)=>{
    const {id} = req.params;
    const {status} = req.body;
    const data = await newsStates.create({
        status: status,
    },{
        where:{idNewsState:id}
    }).then((data)=>{
        return data
    })
    .catch(erro=>{
        console.log('Error no update do newsStatus: ' + erro);
        return erro
    });
    res.json({
        success:true,
        message: 'newsStatus updated com sucesso',
        data:data
    })
}

controller.delet = async (req,res)=>{
    const {id} = req.params;
    const data = await newsStates.create({
       vis: false
    },{
        where:{idNewsState:id}
    }).then((data)=>{
        return data
    })
    .catch(erro=>{
        console.log('Error no delete do newsStatus: ' + erro);
        return erro
    });
    res.json({
        success:true,
        message: 'newsStatus deleted com sucesso',
        data:data
    })
}

module.exports = controller;