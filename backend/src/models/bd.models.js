const Sequelize = require('sequelize');


//* Base de dados de teste
// const BD = new Sequelize(
//     'projeto4bd_ew0t',
//     'olisipo',
//     'B3u9apBEKzSB9j2la8Jgx2p5QeLPXErL',
//     {

//         host: 'dpg-cl9tp85o7jlc73fjcp50-a.frankfurt-postgres.render.com',
//         port: 5432,
//         dialect: 'postgres',
//         logging: console.log,
//         dialectOptions:{
//             ssl: {
//                 require: true,
//                 rejectUnauthorized: false // You may need to set this to true or false based on your PostgreSQL server configuration
//             }
//         }
//     }
// );
const BD = new Sequelize(
    'projeto4bd',
    'olisipomain',
    'wKdfAY3NoRCTHQox8TxY9zT4HBZYVuol',
    {

        host: 'dpg-cl9qife2eqrc7391te70-a.frankfurt-postgres.render.com',
        port: 5432,
        dialect: 'postgres',
        logging: console.log,
        dialectOptions:{
            ssl: {
                require: true,
                rejectUnauthorized: false // You may need to set this to true or false based on your PostgreSQL server configuration
            }
        }
    }
);

module.exports = BD;


