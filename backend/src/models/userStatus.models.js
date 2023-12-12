const Sequelize = require('sequelize');
const BD = require('./bd.models');

const userStatus = BD.define('userStatus',{
    idUserStatus:{
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
    status:{
        type: Sequelize.STRING(45),
        allowNull: false
    },
    vis:{
        type:Sequelize.BOOLEAN,
        allowNull: false
    }
});

module.exports = userStatus;