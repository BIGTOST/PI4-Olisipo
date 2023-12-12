const doc = require('../models/docs.moduls');


const controller = {};

controller.create = async (req,res)=>{
    const id = req.user.id
    const {fileName, serverName} = req.body;
    console.log(req.files)
    // const data = await doc.create({
    //     fileName: fileName,
    //     serverName:serverName,
    //     idUser: idUser,
    //     vis: 1
    // }).then((data)=>{
    //     return data
    //  }).catch(error=>{
    //      console.log('Error de criação do doc: ' + error);
    //      return error
    //  })
    //  res.status(200).json({
    //      success:true,
    //      message:"doc registrado",
    //      data:data
    //  });
}
controller.listAll = async (req,res)=>{
    const data = await doc.findAll()
    .then((data)=>{
        return data
    })
    .catch(error =>{
        console.log('Erro na listagem dos dosc: ' + error);
        return error;
    })
    res.json({
        success: true,
        data:data,
    })
}

controller.list = async (req,res)=>{
    const id= req.user.id
    const data = await doc.findAll({where:{idUser:id}})
    .then((data)=>{
        return data
    })
    .catch(error =>{
        console.log('Erro na listagem dos dosc: ' + error);
        return error;
    })
    res.json({
        success: true,
        data:data,
    })
}

controller.update = async (req,res)=>{
    const {id} = req.params;
    const idUser= req.user.id;
    const {fileName, serverName} = req.body;
    const data = await doc.create({
        fileName: fileName,
        serverName:serverName,
        idUser: idUser
    },{
        where:{idDoc:id}
    })
    .then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error de updated do doc: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"doc updated",
        data:data
    });
}
controller.delete = async (req,res)=>{
    const {id} = req.params;
    const data = await doc.create({
        vis:0
    },{
        where:{idDoc:id}
    })
    .then((data)=>{
        return data
    }).catch(error=>{
        console.log('Error de delete do doc: ' + error);
        return error
    })
    res.status(200).json({
        success:true,
        message:"doc delete",
        data:data
    });
}
module.exports = controller;