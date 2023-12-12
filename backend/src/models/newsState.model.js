const Sequelize = require('sequelize');
const BD = require('./bd.models');

const newsState = BD.define('newsStatus', {
    idNewsState:{
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    state:{
        type: Sequelize.STRING,
        allowNull: false
    },
    vis:{
        type:Sequelize.BOOLEAN,
        allowNull:false
    }
});

module.exports = newsState;