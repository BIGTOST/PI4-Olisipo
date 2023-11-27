const express = require('express');
const route = express.Router();

const userManagerController = require('../controllers/userManager.controller');

route.get('/', userManagerController.list);
route.post('/create', userManagerController.create);
route.post('/update'), userManagerController.update;
route.post('/delete', userManagerController.delete);

module.exports = route;