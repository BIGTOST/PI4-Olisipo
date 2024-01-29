const Sequelize = require('sequelize');
const BD = require('./bd.models');

const calendarEvent = BD.define('calendarevent', {
    idCalendarEvent:{
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement:true
    },
    event:{
        type:Sequelize.STRING,
        allowNull: false
    },
    vis:{
        type:Sequelize.BOOLEAN,
        allowNull: false
    },
    calendarEnventCol: Sequelize.STRING
})

module.exports = calendarEvent