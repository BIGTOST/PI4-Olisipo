const express = require('express');
const route = express.Router();


const middleware = require('../middleware');
const userController = require('../controllers/users.controller');
console.log('passei na route');
route.get('/', middleware,userController.list)
route.get('/changePassword', middleware,userController.changePassword)
route.post('/login', userController.login)
route.post('/update/', middleware, userController.update);
route.post('/delete/', middleware, userController.delete);
route.post('/regist', userController.register)

module.exports = route;