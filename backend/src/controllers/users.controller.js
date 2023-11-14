const profile = require('../models/profiles.model');
const userStatus = require('../models/userStatus.models');
const users = require('../models/users.models');
const BD = require('../models/bd.models');

const controller = {};

BD.sync()
