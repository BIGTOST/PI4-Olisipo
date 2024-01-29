const Sequelize = require('sequelize');
const BD = require('./bd.models');
const users = require('./users.models');

const pushNotificationHistory = BD.define('pushnotificationhistory', {
    idpushNotificationHistory:{
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
    },
    sendedAt:{
        type: Sequelize.DATE,
        allowNull: false
    },
    desc:{
        type:Sequelize.STRING(250),
        allowNull: false
    },
    vis:{
        type: Sequelize.BOOLEAN,
        allowNull:false
    },
});

//* ForeignKeys
//?foreignKe por quem enviou
pushNotificationHistory.belongsTo(users, {foreignKey:'sendBy'});
users.hasMany(pushNotificationHistory, {foreignKey:'sendBy'})

//?foreignKe para que foi enviado
pushNotificationHistory.belongsTo(users, {foreignKey:'sendTo'})
users.hasMany(pushNotificationHistory, {foreignKey:'sendTo'} )

module.exports = pushNotificationHistory