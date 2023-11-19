const Sequelize = require('sequelize');
const BD = require('./bd.models');

const newsType = BD.define('newsType',{
    idNewsType:{
        type: Sequelize.INTEGER,
        priamryKey: true,
        autoIncremente: true
    },
    type:{
        type: Sequelize.STRING,
        allowNull: false
    },
    vis:{
        type: Sequelize.BOOLEAN,
        allowNull: false
    }
});

module.exports = newsType;