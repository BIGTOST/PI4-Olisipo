const express = require('express');
const route = express.Router();

const docController = require('../controllers/doc.controller');

route.get('/', docController.list);
route.post('/delete',docController.create);
route.post('/update', docController.update);
route.post('/delete',docController.delete);

module.exports = route;