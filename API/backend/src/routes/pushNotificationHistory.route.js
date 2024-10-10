const Express = require('express');
const route = Express.Router();

const pNHControllers = require('../controllers/pushNotificationHistory.controller');

route.get('/',pNHControllers.list);
route.get('/all', pNHControllers.listTudo)
route.post('/create',pNHControllers.create);
route.post('/update/:id',pNHControllers.update);
route.post('/delete/:id',pNHControllers.delete);

module.exports = route;