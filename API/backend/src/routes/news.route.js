
//?Import do express e config da route
const express = require('express');
const   route = express.Router();

//?files necessarios
const middleware = require('../middleware');
const newsController = require('../controllers/news.controller');

route.get('/', newsController.list);
route.get('/this/:id', newsController.encontraThis);
route.post('/create', middleware,newsController.create);
route.post('/update/:id', middleware,newsController.update);
route.post('/updateStatus/:id', middleware,newsController.updateStatus);
route.post('/delete/:id', middleware,newsController.delete);


module.exports = route;