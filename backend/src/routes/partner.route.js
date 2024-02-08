const express = require('express');
const route = express.Router();

const partnerController = require('../controllers/partner.controller');

route.get('/', partnerController.list);
route.get('/thisPartner/:id', partnerController.findThisPartner);
route.post('/create', partnerController.create);
route.post('/update/:id', partnerController.update);
route.post('/delete/:id', partnerController.delete);

module.exports = route;