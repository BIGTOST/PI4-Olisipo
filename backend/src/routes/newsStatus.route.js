const express = require('express');
const route = express.Router();

const newsStatuscontroller = require('../controllers/newsStatus.constrollers');


route.get('/', newsStatuscontroller.list);
route.post('/create', newsStatuscontroller.create);
route.post('/update/:id', newsStatuscontroller.update);
route.post('/delet/:id', newsStatuscontroller.delet);
module.exports = route;