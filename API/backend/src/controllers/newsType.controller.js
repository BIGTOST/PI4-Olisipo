const newsType = require('../models/newsType.models');

const controller = {};

controller.create = async (req,res)=>{
    const {type} = req.body;
    const data = newsType.create({
        type:type,
        vis: true
    })
    .then((data)=>{
        return (data);
    })
    .catch(erro =>{
        onsole.log('Erro na craição do type da news: ' +erro);
        return erro
    });
    res.json({
        success: true,
        message:"newsType Criado com sucesso",
        data: data
    });
}

controller.list = async (req, res)=>{
    const data = await newsType.findAll()
    .then((data)=>{
        return data;
    })
    .catch(error=>{
        console.log('Erro na listagem do type da new: ' +error);
        return error
    });
    res.json({
        success: true,
        message:"newsType listado com sucesso",
        data: data
    });
}

controller.update = async (req,res)=>{
    const {id} = req.params;
    const {type} = req.body;
    const data = newsType.create({
        type:type,
    },{
        where:{idNewsType:id}
    })
    .then((data)=>{
        return (data);
    })
    .catch(erro =>{
        onsole.log('Erro na craição do type da news: ' +erro);
        return erro
    });
    res.json({
        success: true,
        message:"newsType Criado com sucesso",
        data: data
    });
}

controller.delet = async (req,res)=>{
    const {id} = req.params;

    const data = newsType.create({
        vis:false,
    },{
        where:{idNewsType:id}
    })
    .then((data)=>{
        return (data);
    })
    .catch(erro =>{
        onsole.log('Erro no delete do type da news: ' +erro);
        return erro
    });
    res.json({
        success: true,
        message:"newsType deleted com sucesso",
        data: data
    });
}

module.exports = controller;