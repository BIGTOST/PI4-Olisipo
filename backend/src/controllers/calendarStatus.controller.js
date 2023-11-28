const calendarStatus =  require('../models/calendarStatus.models');

const  controller = {};

controller.create = async (req,res)=>{
    const {status} = req.body;

    const data = await calendarStatus.create({
        status:status,
        vis:1
    }).then((data) => {
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
    const {id} = req.params
    const {status} = req.body;

    const data = await calendarStatus.update({
        status:status,
    },{
        where:{idCalendarStatus:id}
    }).then((data) => {
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
    const {id} = req.params;
    const data = await calendarStatus.create({

        vis:1
    },{
        where:{idCalendarStatus:id}
    }).then((data) => {
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