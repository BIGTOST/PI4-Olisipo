const calendarEvent = require('../models/calendarEvent.models');

const controller = {};

controller.create = async (req, res)=>{
    const {event }= req.body;

    const data = await calendarEvent.create({
        event: event,
        vis:1,
    }).then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error de criação do calendarEvent: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"CalendarEvent registrado",
        data:data
    });

}

controller.list = async (req, res)=>{
    const data = await calendarEvent.findAll()
    .then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error de listage do calendarEvent: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"calendarEvent lsitado",
        data:data
    });
}

controller.update = async (req, res)=>{
    const {id} = req.params
    const {event, calendarEnventCol }= req.body;

    const data = await calendarEvent.update({
        event: event,
        calendarEventCol:calendarEnventCol
    },{
        where:{idCalendarEvent:id}
    }).then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error no update do calendarEvent: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"CalendarEvent updated",
        data:data
    });
}

controller.delete = async (req, res)=>{
    const {id} = req.params
    const data = await calendarEvent.update({
        vis:0
    },{
        where:{idCalendarEvent:id}
    }).then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error no delete do calendarEvent: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"CalendarEvent deleted",
        data:data
    });
}

module.exports = controller;