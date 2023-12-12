const Sequelize = require('sequelize');
const BD = require('./bd.models');

const calendarEvent = require('./calendarEvent.models');

const calendarEnventType = BD.define('calendarEventType', {
    idCalendarEventType:{
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    event:{
        type:Sequelize.STRING,
        allowNull:false
    },
    vis:{
        type:Sequelize.BOOLEAN,
        allowNull: false
    }
});

calendarEnventType.belongsTo(calendarEvent, {foreignKey:'eventType'});
calendarEvent.hasMany(calendarEnventType, {foreignKey:'eventType'});

module.exports = calendarEnventType;