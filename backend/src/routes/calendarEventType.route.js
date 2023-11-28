const express = require('express');
const route = express.Router();

const calendarEventTypeController = require('../controllers/calendarEventType.controller');

route.get('/',calendarEventTypeController.list);
route.post('/create', calendarEventTypeController.create);
route.post('/update', calendarEventTypeController.update);
route.post('/delete', calendarEventTypeController.delete);

module.exports = route;