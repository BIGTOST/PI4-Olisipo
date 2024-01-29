const Sequelize = require('sequelize');
const BD = require('./bd.models');

const newsType = BD.define('newstypes',{
    idNewsType:{
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
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