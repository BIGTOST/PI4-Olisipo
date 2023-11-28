const calendarEventType = require('../models/calendarEventType.models');

const controller = {};

controller.create = async (req, res)=>{
    const {event, eventTypeId}= req.body;

    const data = await calendarEventType.create({
        event: event,
        vis:1,
        eventType:eventTypeId
    }).then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error de criação do calendarEventType: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"calendarEventType registrado",
        data:data
    });

}

controller.list = async (req, res)=>{
    const data = await calendarEventType.findAll()
    .then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error de listage do calendarEventType: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"calendarEventType lsitado",
        data:data
    });
}

controller.update = async (req, res)=>{
    const {id} = req.params
    const {event, eventTypeId}= req.body;

    const data = await calendarEventType.update({
        event: event,
        eventType:eventTypeId
    },{
        where:{idCalendarEventType:id}
    }).then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error no update do calendarEventType: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"calendarEventType updated",
        data:data
    });
}

controller.delete = async (req, res)=>{
    const {id} = req.params
    const data = await calendarEventType.update({
        vis:0
    },{
        where:{idCalendarEventType:id}
    }).then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error no delete do calendarEventType: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"calendarEventType deleted",
        data:data
    });
}

module.exports = controller;