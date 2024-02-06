const express = require('express');
const route = express.Router();

const logsController = require('../controllers/logs.controller');


route.get('/', logsController.listLogs);

module.exports = route;