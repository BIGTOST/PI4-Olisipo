const Sequelize = require('sequelize');
const BD = require('./bd.models');

const users = require('./users.models');

const partner = BD.define('partner', {
    idPartner:{
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncremente: true
    },
    nome:{
        type: Sequelize.STRING,
        allowNull: false
    },
    imgPath:{
        type:Sequelize.STRING,
        allowNull:false
    },
    vis:{
        type:Sequelize.BOOLEAN,
        allowNull:false
    }
});

//* ForeignKeys
//? um parceiro foi registrado por user, vulgo um admin
partner.belongsTo(users, {foreignKey:'createBy'});
users.hasMany(partner, {foreignKey:'createBy'});

module.exports = partner;