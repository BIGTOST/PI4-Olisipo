const express = require('express');
const route = express.Router();

const profileController = require('../controllers/profile.controller')

route.get('/', profileController.list);

module.exports = route;