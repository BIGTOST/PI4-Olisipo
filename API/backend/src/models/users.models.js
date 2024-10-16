const Sequelize = require('sequelize');
const BD = require('./bd.models');

//*package de cryptografia
const bcrypt = require('bcrypt')

//*chamada das tabelas que são FK no user
const profile = require('./profiles.model');
const status = require('./userStatus.models');

const users = BD.define('users',{
    idUser: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
    name:{
        type: Sequelize.STRING(200),
        allowNull: false
    },
    email:{
        type: Sequelize.STRING(200),
        unique: true,
        allowNull: false
    },
    phone:{
        type:Sequelize.STRING(9),
    },
    address:{
        type: Sequelize.STRING(200),
    },
    driver:{
        type: Sequelize.BOOLEAN,
    },
    imgPath:{
        type:Sequelize.STRING(200)
    },
    password:{
        type:Sequelize.STRING(200),
        allowNull: false
    },
    vis:{
        type:Sequelize.BOOLEAN,
        allowNull: false
    }
});


//*encriptação da palavra passe ante do user ser criado
users.beforeCreate((users, options)=>{
    return bcrypt.hash(users.password, 10)
    .then(hash => {
        users.password = hash;
    })
    .catch(err =>{
        throw new Error()
    });
});

//* relações
//?Relação com o manager
users.hasOne(users, 
    {
        foreignKey:{
            name:'manager',
            allowNull:true
        }
    }
);

users.belongsTo(users, 
    {
        foreignKey:{
            name:'manager',
            allowNull:true
        }
    }
);

//? Relação com a tabela profile, um user tem um profile
users.belongsTo(profile, {foreignKey:'profileUser'});
profile.hasMany(users, {foreignKey: 'profileUser'});

//?Relação com a tabela
users.belongsTo(status, {foreignKey:'statusUser'});
status.hasMany(users,{foreignKey:'statusUser'});

module.exports = users;