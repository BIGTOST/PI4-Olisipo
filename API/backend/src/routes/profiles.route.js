const express = require('express');
const route = express.Router();

const profileController = require('../controllers/profile.controller')

route.get('/', profileController.list);
route.post('/create', profileController.create);
route.post('/update/:id',  profileController.update);
route.post('/delet/:id', profileController.delet);
module.exports = route;