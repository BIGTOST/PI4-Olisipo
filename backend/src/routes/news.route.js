
//?Import do express e config da route
const express = require('express');
const route = express.Router();

//?files necessarios
const newsController = require('../controllers/news.controller');

route.get('/', newsController.list);
route.post('/create', newsController.create);
route.post('/update/:id', newsController.update);
route.post('/delete/:id', newsController.delete);


module.exports = route;