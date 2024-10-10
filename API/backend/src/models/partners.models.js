const Sequelize = require('sequelize');
const BD = require('./bd.models');

const users = require('./users.models');

const partner = BD.define('partner', {
    idPartner:{
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    nome:{
        type: Sequelize.STRING,
        allowNull: false
    },
    imgPath:{
        type:Sequelize.STRING,  
    },
    vis:{
        type:Sequelize.BOOLEAN,
        allowNull:false
    }
});

//* ForeignKeys

module.exports = partner;