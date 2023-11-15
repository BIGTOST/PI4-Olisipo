const BD = require('../models/bd.models');
const profiles = require('../models/profiles.model');

const controller = {};

controller.list = async (req,res)=>{
    const data = await profiles.findAll()
    .then((data)=>{
        return data
    })
    .catch(error =>{
        return error;
    })
    res.json({
        success: true,
        data:data,
    })
}

module.exports = controller;