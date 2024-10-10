const Sequelize = require('sequelize');
const BD = require('./bd.models');

const calendarStatus = BD.define('calendarstatus', {
    idCalendarStatus:{
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    status:{
        type:Sequelize.STRING,
        allowNull: false
    },
    vis:{
        type: Sequelize.BOOLEAN,
        allowNull: false
    }
});

module.exports = calendarStatus