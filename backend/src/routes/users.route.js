const express = require('express');
const route = express.Router();

const middleware = require('../middleware');
const userController = require('../controllers/users.controller');

route.get('/', middleware.checkToken, userController.list)
route.post('/login', userController.login)
route.post('/update/:id', middleware.checkToken, userController.update);
route.post('/delete/:id', middleware.checkToken, userController.delete);
route.post('/regist', userController.register)

module.exports = route;