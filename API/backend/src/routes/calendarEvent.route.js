const express = require('express');
const route = express.Router();

const calendarEventController = require('../controllers/calendarEvent.controller');

route.get('/',calendarEventController.list);
route.post('/create', calendarEventController.create);
route.post('/update', calendarEventController.update);
route.post('/delete', calendarEventController.delete);

module.exports = route;