const Sequelize = require('sequelize');
const BD = require('./bd.models');

const profiles = BD.define('profiles',{
    idProfile:{
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
    profile:{
        type: Sequelize.STRING(45),
        allowNull: false
    },
    vis:{
        type: Sequelize.BOOLEAN,
    allowNull: false
    }
});

module.exports = profiles;