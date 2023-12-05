const jwt = require("jsonwebtoken");
const config = require("./config");

module.exports = (req, res, next) => {
    let token = req.header("authorization");
    console.log(token);
    if(token && token.startsWith('Bearer ')){
        //?remoção do 'Bearer ' do token
        token = token.slice(7, token.length)
        console.log(token);
    }

    try {
       console.log(token + "Dentro do Try")
        if (!token) return res.status(403).send("Access denied.");

        const decoded = jwt.verify(token, config.jwtSecret);
        console.log(decoded)
        req.user = decoded;
        next();
    } catch (error) {
        res.status(400).send("Invalid token");
    }
};
