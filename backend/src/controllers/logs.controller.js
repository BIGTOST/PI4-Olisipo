const logs = require('../models/logs.models');
const controller ={};

controller.createLog = async (des, userId,)=>{
    let description = des;
    const id = userId;
    console.log('passei nos logs')
    console.log(des);
    console.log(description)
    const data = await logs.create({
        Desc:description,
        userId:id
    })
    .then((data)=>{
        console.log('Log registrado com sucesso.')
        console.log(data)
    })
}

controller.listLogs = async (req,res)=>{
    const data =await logs.findAll()
    .then((data)=>{
        return data
    })
    .catch(error=>{
        return error;
    });
    res.status(200).json({
        success:true,
        message: 'Logs Listagem',
        data:data
    });

}   

module.exports = controller;