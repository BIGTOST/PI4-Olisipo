const Sequelize = require('sequelize');
const BD = require('./bd.models');

const users = require('./users.models');
const partner = require('./partners.models');

const projHistory = BD.define('projHistory', {
    idProjHistory:{
        type: Sequelize.INTEGER,
        primaryKey:true,
        autoIncremente: true
    },
    decProj: {
        type: Sequelize.INTEGER,
        allowNull: false
    },
    vis:{
        type:Sequelize.BOOLEAN,
        allowNull:false
    }
});

//* ForeignKeys
//?  projecto tem um parceiro
projHistory.belongsTo(partner, {foreignKey:'idPartner'});
partner.hasMany(projHistory,{foreignKey:'idPartner'});

//? projecto foi realizado por um user
projHistory.belongsTo(users, {foreignKey:'idUser'});
users.hasMany(projHistory,{foreignKey:'idUser'});

module.exports = projHistory;
