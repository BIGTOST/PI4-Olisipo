const express = require('express');
const route = express.Router();

const docController = require('../controllers/doc.controller');

route.get('/', docController.list);
route.post('/create',docController.create);
route.post('/update/:id', docController.update);
route.post('/delete/:id',docController.delete);

module.exports = route;