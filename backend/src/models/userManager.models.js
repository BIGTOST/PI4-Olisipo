const Sequelize = require('sequelize');
const BD = require('./bd.models');

const users = require('./users.models');

const userManager = BD.define('userManager', {
    idUserManger:{
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncremente: true
    },
    vis:{
        type: Sequelize.BOOLEAN,
        allowNull: false
    }
});

//*ForeignKeys
//?FK do user
userManager.belongsTo(users, {foreignKey:'idUser'});
users.hasMany(userManager, {foreignKey:'idUser'});

//?FK fo
userManager.belongsTo(users, {foreignKey:'idManager'});
users.hasMany(userManager, {foreignKey:'idManager'});

module.exports = userManager;
