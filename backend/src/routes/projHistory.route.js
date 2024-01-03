const express = require('express');
const route = express.Router();

const projHistoryController = require('../controllers/projHistory.controller');

route.get('/', projHistoryController.list);
route.get('/all', projHistoryController.listAll);
route.post('/create', projHistoryController.create);
route.post('/update/;id', projHistoryController.update);
route.post('/delete/:id', projHistoryController.delete);

module.exports = route;