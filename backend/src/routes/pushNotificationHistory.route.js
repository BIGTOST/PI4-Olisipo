const Express = require('express');
const route = Express.Router();

const pNHControllers = require('../controllers/pushNotificationHistory.controller');

route.get('/',pNHControllers.create);
route.post('/',pNHControllers.list);
route.post('/',pNHControllers.update);
route.post('/',pNHControllers.delete);

module.exports = route;