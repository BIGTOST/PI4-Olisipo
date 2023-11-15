const express = require('express');
const route = express.Router();

const middleware = require('../middleware');
const userController = require('../controllers/users.controller');

route.get('/',middleware.checkToken, userController.list)
route.post('/login', userController.login)
route.post('/regist', userController.register)

module.exports = route;