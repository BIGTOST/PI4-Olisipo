const Sequelize = require('sequelize');
const BD = require('./bd.models');

const users = require('./users.models');
const docs = require('./docs.moduls');
const calendarStatus = require('./calendarStatus.models');
const calendarEvent = require('./calendarEvent.models');
const calendarEnventType = require('./calendarEventType.models');

const calendar = BD.define('calendar',{
    idCalendar:{
        type: Sequelize.INTEGER,
        primaryKey:true,
        autoIncremente: true
    },
    start:{
        type:Sequelize.DATE,
        allowNull: false,
    }, 
    end:{
        type:Sequelize.DATE,
        allowNull: false
    },
    vis:{
        type:Sequelize.BOOLEAN,
        allowNull:false
    }
});

//* FALTA FAZER AS fk