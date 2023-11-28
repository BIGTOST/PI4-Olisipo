const calendar = require('../models/calendar.models');

const controller = {};

controller.create = async (req,res) =>{
    const {start, end,  idUser, status, event, idEventType, idDoc} = req.body;
    const data = await calendar.create({
        start:start,
        end:end,
        vis:1,
        idUser:idUser,
        status:status,
        event:event,
        idEventType:idEventType,
        idDoc:idDoc
    })
    .then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error de criação do calendar: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"calendar registrado",
        data:data
    });
}

controller.list = async (req,res) =>{
    const data = await calendar.findAll()
    .then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error na listagem dos calendar: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"calendar listados",
        data:data
    });
}
controller.update = async (req,res) =>{
    const {id} = req.params;
    const {start, end, status, event, idEventType, idDoc} = req.body;
    const data = await calendar.update({
        start:start,
        end:end,
        status:status,
        event:event,
        idEventType:idEventType,
        idDoc:idDoc
    },{
        where:{idCalendar:id}
    })
    .then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error de update do calendar: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"calendar updated",
        data:data
    });
}

controller.delete = async (req,res) =>{
    const {id} = req.params;
    const data = await calendar.update({
        vis:0
    },{
        where:{idCalendar:id}
    })
    .then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error no delete do calendar: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"calendar deleted",
        data:data
    });
}
module.exports = controller