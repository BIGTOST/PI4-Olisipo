const calendarStatus =  require('../models/calendarStatus.models');
const log = require('./logs.controller');

const  controller = {};

controller.create = async (req,res)=>{
    const id = req.user.id
    const {status} = req.body;

    const data = await calendarStatus.create({
        status:status,
        vis:1
    }).then((data) => {
        
        log.createLog('Novo calendar Status Registrado: '+status+'  pelo user de id:'+id, id);
        return data
        
    }).catch((err) => {
        console.log('Error de criação do calendarStatus: ' + err);
        return err
    });
    res.status(200).json({
        success:true,
        message:"calendarStatus registrado",
        data:data
    });
}

controller.list = async (req,res)=>{
    const data = await calendarStatus.findAll()
    .then((data) => {
        log.createLog('calendar Status Listado pelo user de id:'+id, id);
        return data
    }).catch((err) => {
        console.log('Error de listagem do calendarStatus: ' + err);
        return err
    });
    res.status(200).json({
        success:true,
        message:"calendarStatus listado",
        data:data
    });
}

controller.update = async (req,res)=>{
    const userId = req.user.id
    const {id} = req.params
    const {status} = req.body;
    const oldData = await calendarStatus.findAll({
        attributes:['status'],
        where: {idCalendarStatus:id}
    })
    .then((data) => {
            const status = data.map(user => user.dataValues.status);
            console.log(status);
            return status;
    })
    .catch(err=>{
        return err
    })

    const data = await calendarStatus.update({
        status:status,
    },{
        where:{idCalendarStatus:id}
    }).then((data) => {
        log.createLog('calendar Status de id:'+id+', atualizado de {'+oldData+'} para {'+status+'}', userId);
        return data
        
    }).catch((err) => {
        console.log('Error de update do calendarStatus: ' + err);
        return err
    });
    res.status(200).json({
        success:true,
        message:"calendarStatus update",
        data:data
    });
}

controller.delete = async (req,res)=>{
    const idUser = req.user.id;
    const {id} = req.params;
    const data = await calendarStatus.create({
        vis:0
    },{
        where:{idCalendarStatus:id}
    }).then((data) => {
        log.createLog('O calendar Status de Id:'+id+' , deixou de estar visivel, ação pelo user de id: '+ idUser, idUser)
        return data
        
    }).catch((err) => {
        console.log('Error no delete do calendarStatus: ' + err);
        return err
    });
    res.status(200).json({
        success:true,
        message:"calendarStatus deleted",
        data:data
    });
}


module.exports = controller