const Sequelize = require('sequelize');
const BD = require('./bd.models');

const users = require('./users.models');
const docs = require('./docs.moduls');
const calendarStatus = require('./calendarStatus.models');
const calendarEvent = require('./calendarEvent.models');
const calendarEventType = require('./calendarEventType.models');

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

calendar.belongsTo(users, {foreignKey:'idUser'});
users.hasMany(calendar, {foreignKey:'idUser'});

calendar.belongsTo(calendarStatus, {foreignKey:'status'});
calendarStatus.hasMany(calendar, {foreignKey:'status'});

calendar.belongsTo(calendarEvent, {foreignKey:'event'});
calendarEvent.hasMany(calendar, {foreignKey:'event'});

calendar.belongsTo(calendarEventType, {foreignKey:'idEventType'});
calendarEventType.hasMany(calendar, {foreignKey:'idEventType'});

calendar.belongsTo(docs, {foreignKey:'idDoc'});
docs.hasMany(calendar, {foreignKey:'idDoc'});

module.exports = calendar
