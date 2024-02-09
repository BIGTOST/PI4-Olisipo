const Sequelize = require('sequelize');
const BD = require('./bd.models');

const users = require('./users.models');
const docs = require('./docs.moduls');
const calendarStatus = require('./calendarStatus.models');
const calendarEvent = require('./calendarEvent.models');

const calendar = BD.define('calendar',{
    idCalendar:{
        type: Sequelize.INTEGER,
        primaryKey:true,
        autoIncrement: true
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
    },
    decrip:{
        type:Sequelize.STRING(2000),
        allowNull:true
    }
});

//* FALTA FAZER AS fk

calendar.belongsTo(users, {foreignKey:'idUser'});
users.hasMany(calendar, {foreignKey:'idUser'});

calendar.belongsTo(calendarStatus, {foreignKey:'status'});
calendarStatus.hasMany(calendar, {foreignKey:'status'});

calendar.belongsTo(calendarEvent, {foreignKey:'event'});
calendarEvent.hasMany(calendar, {foreignKey:'event'});


calendar.belongsTo(docs, {foreignKey:'idDoc'});
docs.hasMany(calendar, {foreignKey:'idDoc'});

module.exports = calendar
