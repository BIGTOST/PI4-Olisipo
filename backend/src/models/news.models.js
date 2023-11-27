const Sequelize = require('sequelize');
const BD = require('./bd.models');

const users = require('./users.models');
const newsState = require('./newsState.model');
const newsType = require('./newsType.models');

const news= BD.define('news',{
    idNews :{
        type:Sequelize.INTEGER,
        primaryKey: true,
        autoIncremente: true
    },
    tittle:{
        type:Sequelize.STRING,
        allowNull: false
    },
    text:{
        type: Sequelize.STRING(45000),
        allowNull: false
    },
    imgPath:{
        type: Sequelize.STRING(),
        allowNull:false
    },
    vis:{
        type: Sequelize.BOOLEAN,
        allowNull: false
    }
});

//*Foreign Keys
//?FK  para quem publicou
news.belongsTo(users, {foreignKey:'madeBy'});
users.hasMany(news, {foreignKey:'madeBy'});

//?FK para quem aprovou
news.belongsTo(users, {foreignKey:'aproveBy'});
users.hasMany(news, {foreignKey:'aproveBy'});

//?FK de  typeNews
news.belongsTo(newsType, {foreignKey:'type'});
newsType.hasMany(news, {foreignKey:'type'});

//? FK para sabe se a noticia foi aprovada ou não
news.belongsTo(newsState, {foreignKey:'state'});
newsState.hasMany(news, {foreignKey:'state'});

module.exports = news