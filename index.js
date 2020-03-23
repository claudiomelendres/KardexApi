const mysql = require('mysql');
const express = require('express');
var app = express();
const bodyparser = require('body-parser');
let Sender = require('../KardexApi/utils/sender');

app.use(bodyparser.json());

var mysqlConnection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'secret',
    database: 'db_kardex',
    port: '3308',
    multipleStatements: true
});

mysqlConnection.connect((err) => {
    if (!err)
        console.log('DB connection succeded.');
    else
        console.log('DB connection failed \n Error : ' + JSON.stringify(err, undefined, 2));
});


app.listen(3001, () => console.log('Express server is runnig at port no : 3001'));


//Get all kardexentry
app.get('/kardexentry', (req, res) => {
    mysqlConnection.query('SELECT * FROM kardexentry', (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});

//Get all kardexentry
app.get('/inventory', (req, res) => {
    mysqlConnection.query('SELECT * FROM inventory', (err, rows, fields) => {
        if (!err)
            res.send(rows);
        else
            console.log(err);
    })
});




//Insert an kardex

app.post('/kardexentry', (req, res) => {

    //Sender.sendExchage("mesageClaudio");

    let kardexentry = req.body;
    console.log("-----------------1");
    console.log(kardexentry);
    var sql = "Insert into kardexentry \
    (kardex_id, entry_date, entry_quantity, entry_price, is_a_sale, user_id) \
values ('"+kardexentry.kardex_id+"','"+kardexentry.entry_date+"','"+kardexentry.entry_quantity+"','"+kardexentry.entry_price+"','"+JSON.parse(kardexentry.is_a_sale)+"','"+kardexentry.user_id+"');";

    mysqlConnection.query(sql, (err, rows, fields) => {
        if (err)
            throw err;
        else
        {
            console.log("1 record inserted");
            res.send(rows);
        }
    })
});






