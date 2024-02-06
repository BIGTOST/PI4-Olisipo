const express = require('express');
const route = express.Router()

const calendarStatusController =  require('../controllers/calendarStatus.controller');

route.get('/', calendarStatusController.list)
route.post('/create',calendarStatusController.create);
route.post('/update/:id',calendarStatusController.update);
route.post('/delete/:id',calendarStatusController.delete);

module.exports = route