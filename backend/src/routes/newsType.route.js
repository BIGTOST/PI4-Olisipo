const express = require('express');
const route = express.Router();

const newsTypeController = require('../controllers/newsType.controller');

route.get('/', newsTypeController.list);
route.post('/create', newsTypeController.create);
route.post('/update/:id', newsTypeController.update);
route.post('/delet/:id', newsTypeController.delet);

module.exports = route;