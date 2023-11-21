
//?Import do express e config da route
const express = require('express');
const route = express.Router();

//?files necessarios
const userStatusController = require('../controllers/userStatus.controller');

route.get('/', userStatusController.list);
route.post('/create', userStatusController.create);
route.post('/update/:id', userStatusController.update);
route.post('/delet/:id', userStatusController.delete);

module.exports = route;