const jwt = require('jsonwebtoken');
const config = require('./config');

let checkToken = (req,res,next)=>{
    let token = req.headers['X-acess-token'] || req.headers['authorization'];

        console.log(token);
    if(token && token.startsWith('Bearer ')){
        //?remoção do 'Bearer ' do token
        token = token.slice(7, token.length)
    }

    if(token){
        jwt.verify(token, config.jwtSecret, (err, decoded)=>{
            if(err){
                return res.json({
                    success: false,
                    message: 'token não é valido'
                });
            }else{
                req.decoded = decoded;
                next();
            }
        });
    }
    else{
        return res.json({
            success:false,
            message: 'Token Indisponível.'
        });
    }
}

module.exports = {
    checkToken: checkToken
}