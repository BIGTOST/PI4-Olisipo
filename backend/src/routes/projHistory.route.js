const express = require('express');
const route = express.Router();

const projHistoryController = require('../controllers/projHistory.controller');

route.get('/', projHistoryController.list);
route.post('/create', projHistoryController.create);
route.post('/update', projHistoryController.update);
route.post('/delete', projHistoryController.delete);

module.exports = route;