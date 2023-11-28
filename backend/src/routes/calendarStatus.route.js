const express = require('express');
const route = express.Router()

const calendarStatusController =  require('../controllers/calendarStatus.controller');

route.get('/', calendarStatusController.list)
route.post('/',calendarStatusController.create);
route.post('/',calendarStatusController.update);
route.post('/',calendarStatusController.delete);

module.exports = route