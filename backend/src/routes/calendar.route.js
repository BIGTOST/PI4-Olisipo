const express = require('express');
const route = express.Router();

const calendarController = require('../controllers/calendar.controller');

route.get('/', calendarController.list);
route.post('/create', calendarController.create);
route.post('/update', calendarController.update);
route.post('/delete', calendarController.delete);


module.exports = route