const Express = require('express');
const route = Express.Router();

const pNHControllers = require('../controllers/pushNotificationHistory.controller');

route.get('/',pNHControllers.list);
route.post('/create',pNHControllers.create);
route.post('/update',pNHControllers.update);
route.post('/delete',pNHControllers.delete);

module.exports = route;