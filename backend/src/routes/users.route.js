const express = require('express');
const route = express.Router();


const middleware = require('../middleware');
const userController = require('../controllers/users.controller');


route.get('/', middleware,userController.list)
route.get('/encontra', middleware, userController.encontrar);
route.get('/encontraThis/:id', middleware, userController.encontrarThis);
route.post('/changePassword', middleware,userController.changePassword)
route.post('/changePasswordThis', middleware,userController.changePassword)
route.post('/login', userController.login)
route.post('/update', middleware, userController.update);
route.post('/updateThis/:id', middleware, userController.updateThis);
route.post('/delete/:id', middleware, userController.delete);
route.post('/regist', userController.register)
route.post('/recover', userController.recoverPasswordQuery)
route.post('/recoverChagePass', middleware,userController.recoverPassword)

module.exports = route;