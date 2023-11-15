const Sequelize = require('sequelize');
const BD = require('./bd.models');

const users = require('./users.models');

const docs = BD.define('docs', {
    idDoc:{
        type:Sequelize.INTEGER,
        primaryKey: true,
        autoIncremente: true
    },
    fileName:{
        type: Sequelize.STRING,
        allowNull:false
    },
    serverName:{
        type:Sequelize.STRING,
        allowNull: false
    },
    vis:{
        type: Sequelize.BOOLEAN,
        allowNull:false
    }
});

users.belongsTo(docs, {foreignKey:'idUser'});
docs.belongsTo(users, {foreignKey:'idUser'});


module.exports = docs;