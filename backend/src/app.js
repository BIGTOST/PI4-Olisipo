const express = require('express');
const app =  express();
const cors = require('cors');

//* Import das Routes
const userRoute = require('./routes/users.route');
const profileRoute = require('./routes/profiles.route');
const userStatusRoute = require('./routes/userStatus.route');
const middleware = require('./middleware');

app.set('port', process.env.PORT || 8080)

//middlewares com cors e express
app.use(express.json());
app.use(cors());

//* routes 
//?route de user
app.use('/user', userRoute);

//?route de profiles
app.use('/profiles', middleware.checkToken, profileRoute);



//*rotas raizes de teste
//? rota de teste
app.use('/teste',(req, res)=>{
    res.send(
        '² E o teste era sem forma e vazio; e havia nada sobre a face do browser; e o programador se movia sobre a face das linhas de codigo.');
})

//! lembrete, rota raiz deve ser sempre a mais em baixo
//? rota raiz
app.use('/',(req, res)=>{
    res.send('¹ No princípio, o programador criou o root e o teste');
});


//?escuta para informar em que porta está a ser iniciada o server
app.listen(app.get('port'), ()=>{
    console.log('O server iniciou na porta: ' + app.get('port'));
});