const Sequelize = require('sequelize');
const BD = require('./bd.models');

const user = require('./users.models');

const logs = BD.define('logs', {
    idLogs:{
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncremente:true
    },
    createdAt:Sequelize.DATE,
    Desc: Sequelize.STRING(20000)
},{
    timestamps: false
});

user.hasMany(logs, {foreignKey:'userId'});
logs.belongsTo(user, {foreignKey:'userId'});

module.exports = logs;