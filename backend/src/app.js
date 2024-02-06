const express = require('express');
const fileUpload = require('express-fileupload');
const path = require('path')
const app =  express();
const cors = require('cors');

//* Import das Routes
const userRoute = require('./routes/users.route');
const profileRoute = require('./routes/profiles.route');
const userStatusRoute = require('./routes/userStatus.route');
const newsStatusRoute = require('./routes/newsStatus.route');
const newsTypeRoute = require('./routes/newsType.route');
const newsRoute = require('./routes/news.route');
const docRoute = require('./routes/doc.route');
const partnerRoute = require('./routes/partner.route');
const projHistoryRoute = require('./routes/projHistory.route');
const pNHRoute = require('./routes/pushNotificationHistory.route');
//const userManagerRoute = require('./routes/userManager.route');
const calendarRoute = require('./routes/calendar.route');
const calendarEventRoute = require('./routes/calendarEvent.route');
const calendarStatusRoute = require('./routes/calendarStatus.route');
const calendarEventTypeRoute = require('./routes/calendarEventType.route');
const logsRoute = require('./routes/logs.route');

const middleware = require('./middleware');


app.set('port', process.env.PORT || 8080)
const publicFolder = path.join(__dirname, './public')

//middlewares com cors e express
app.use(express.json());
app.use(cors());
app.use(fileUpload());

//* routes
//?route de users
app.use('/user', userRoute);
//?route de profiles
app.use('/profiles',middleware, profileRoute);
//?route do userStatus
app.use('/userStatus', middleware, userStatusRoute);
//? route do userManager
//app.use('/userManager', middleware, userManagerRoute);
//?route  do Push Notification History
app.use('/pushNotificationHistory', middleware, pNHRoute);
//?route do projectHistory
app.use('/projHistory', middleware, projHistoryRoute);
//?route do partner
app.use('/partners', middleware, partnerRoute);
//?route das Docs
app.use('/docs', middleware, docRoute);


//?routes news
app.use('/news', newsRoute);
//? route newsType
app.use('/newsType', newsTypeRoute);
//? route newsStatus
app.use('/newsStatus', newsStatusRoute);

//?calendar routes
app.use('/calendar',middleware, calendarRoute);
//? calendar Event route
app.use('/calendarEvent',middleware, calendarEventRoute);
//?calendar Status route
app.use('/calendarStatus',middleware, calendarStatusRoute);
//?calendar Event Type route
app.use('/calendarEventType',middleware, calendarEventTypeRoute);

//?Logs Route
app.use('/logs', middleware, logsRoute)



//*rotas raizes de teste
//? rota de teste
app.use('/teste',(req, res)=>{
    res.send(
        '² E o teste era sem forma e vazio; e havia nada sobre a face do browser; e o programador se movia sobre a face das linhas de codigo.');
})

app.post('/upload', function(req, res) {
    //console.log(req.files.foo);
    const file = req.files.foo;
    const fileName = file.name.toString();
    console.log(fileName)
    console.log(file)
    console.log(file.mimetype);
    if(fileName.search('.jpg')||fileName.search('.jpeg')||fileName.search('.png')){
        file.mv(path.join(publicFolder+'/img', file.name ));
    }
    else if(fileName.search('.pdf')){
        file.mv(path.join(publicFolder+'/pdf', file.name ));
    }
    else{
        file.mv(path.join(publicFolder, file.name ));
    }
    res.status(200).json({
         message:"deu certo"
    });
    //  // the uploaded file object
});

app.use('/image', (req,res)=>{
    res.sendFile(publicFolder+'/img/vw6c9iwr6rk51.wedp');
})
app.use('/pdf', (req,res)=>{
    res.sendFile(publicFolder+'/pdf/Curriculo_Alexandre_Cardoso.pdf');
})
app.use('/root/pdf', (req,res)=>{
    res.sendFile(publicFolder+'/sample.pdf');
})
app.use('/root/img', (req,res)=>{
    res.sendFile(publicFolder+'/download.jpeg');
})

//! lembrete, rota raiz deve ser sempre a mais em baixo
//? rota raiz
app.use('/',(req, res)=>{
    res.send('¹ No princípio, o programador criou o root e o teste' );
});


//?escuta para informar em que porta está a ser iniciada o server
app.listen(app.get('port'), ()=>{
    console.log('O server iniciou na porta: ' + app.get('port'));
});
