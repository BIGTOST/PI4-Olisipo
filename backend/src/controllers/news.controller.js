const BD = require('../models/bd.models');
const news = require('../models/news.models');
const logs = require('./logs.controller');

const controller = {};

controller.create = async (req,res) =>{
   const id = req.user.id;
   console.log(id+"    "+req.user.id)
   const {title, text,type} = req.body;
   const data = news.create({
      tittle:title,
      text:text,
      vis: true,
      madeBy:id,
      type:type,
      state:2,
   }).then((data)=>{
      logs.createLog('Nova noticia de Titulo: '+title+', criada pelo user de id: '+id+'.', id);
      return data
   }).catch(error=>{
      console.log('Erro na criação da news: ' +error);
      return error
   });
   res.status(200).json({
      success:true,
      message:"news Criado com sucesso",
      data:data
   });
}

controller.list = async (req, res) => {
   const data = await news.findAll()
   .then((data)=>{
      return data
   })
   .catch(error=>{
      return error
   })
   res.json({
      success: true,
      message:'Boas novas encontradas',
      data: data
   })
}

controller.encontraThis = async (req, res) => {
   const {id} = req.params;
   const data = await news.findAll({
      where:{idNews:id}
   })
   .then((data)=>{
      return data
   })
   .catch(error=>{
      return error
   })
   res.json({
      success: true,
      message:'Boas novas encontradas',
      data: data
   })
}

controller.update = async (req,res)=>{
   const userId = req.user.id;
   const {id} = req.params;
    const {tittle, text, type, vis} = req.body;
    const data = news.update({
      tittle:tittle,
      text:text,
      type:type,
      vis:vis
   },{
      where:{idNews:id}
   }).then((data)=>{
      logs.createLog('Noticia de Titulo: '+title+', criada pelo user de id: '+userId+'.', userId);
     return data
   }).catch(error=>{
     console.log('Erro no update da news: ' +error);
     return error
  });
  res.status(200).json({
     success:true,
     message:"news updated com sucesso",
     data:data
  });
}

controller.updateStatus = async (req,res)=>{
   const userId = req.user.id;
   const {id} = req.params;
   const {status} = req.body
   const oldData = await calendarStatus.findAll({
      attributes:['state'],
      where: {idNews:id}
  })
  .then((data) => {
      const state = data.map(user => user.dataValues.state);
      console.log(state);
      return state;
  })
  .catch(err=>{
      return err
  })
   const data = news.update({
      state: status,
      aproveBy:userId
   },{
      where:{idNews:id}
   }).then((data)=>{
      logs.createLog('Noticia de Titulo: '+title+', teve seu status atualizado de: '+oldData+' pelo user de id:'+id+'.', id);
     return data
   }).catch(error=>{
     console.log('Erro no update da news: ' +error);
     return error
  });
  res.status(200).json({
     success:true,
     message:"news updated com sucesso",
     data:data
  });
}

controller.delete = async (req,res)=>{
   const {id} = req.params;
    const data = news.update({
         vis:false
   },{
      where:{idNews:id}
   })
   .then((data)=>{
     return data
   })
   .catch(error=>{
     console.log('Erro no delete da news: ' +error);
     return error
  });
  res.status(200).json({
     success:true,
     message:"news deleted com sucesso",
     data:data
  });
}

module.exports = controller;