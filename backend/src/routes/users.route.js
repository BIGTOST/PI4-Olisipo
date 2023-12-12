const express = require('express');
const route = express.Router();


const middleware = require('../middleware');
const userController = require('../controllers/users.controller');


route.get('/', middleware,userController.list)
route.get('/encontra', middleware, userController.encontrar)
route.post('/changePassword', middleware,userController.changePassword)
route.post('/login', userController.login)
route.post('/update', middleware, userController.update);
route.post('/delete', middleware, userController.delete);
route.post('/regist', userController.register)

module.exports = route;