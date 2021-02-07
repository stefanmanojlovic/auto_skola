var express = require('express');
var router = express.Router();
var mysql=require('mysql');
var alerts=require('alert');
var bodyParser=require('body-parser');
const multer=require('multer');
const upload=multer();
var session = require('express-session');


router.use(session({
  secret: 'secret',
  resave: true,
  saveUninitialized: true
}));

router.use(bodyParser.urlencoded({extended : true}));
router.use(bodyParser.json())



function randomIdGenerator(){

  randomIdGenerator = function(){}
  var ids=[];
  for(var i=0; i<5;i++){
    var n=Math.floor(Math.random() * 15 + 1);

    if(ids.indexOf(n)==-1){

      ids.push(n);


    }
    else{
      i--;
    }
  }
  return ids;

}


var idsPick=randomIdGenerator();
console.log(idsPick);


router.get('/errorPage', function (req,res,next){

  res.render('errorPage.ejs',{title:"Error Page"});

});
router.get('/secondTryError', function (req,res,next){

  res.render('secondTryError.ejs',{title:"Error Page"});

});
var routes = ['/', '/login'];
router.get(routes, function(req, res, next) {
  res.render('login',{title:"Login"});
});
router.post('/authentication', function(req, res) {
  const con = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    database: 'auto_skola'
  });
  var email = req.body.email;
  var password = req.body.password;
  if (email && password) {
    con.query('SELECT * FROM korisnici WHERE email = ? AND sifra = ?', [email, password], function(error, results, fields) {
      if (results.length > 0) {
        req.session.loggedin = true;
        req.session.email = email;
        req.session.password=password;
        req.session.userId=results[0].id;
        res.redirect('/questionone');
      } else {
        res.send('Incorrect Email and/or Password!');
      }
      res.end();
    });
  } else {
    res.send('Please enter Email and Password!');
    res.end();
  }
});
router.get('/logout', async (req, res) => {
  req.session.destroy(() => {
    res.redirect('/login');
  })
})
router.get('/registration', function(req, res, next) {
  res.render('registration',{title:"Registration"});
});
router.post('/registration', function (req,res,next){
    const con = mysql.createConnection({
      host: 'localhost',
      user: 'root',
      database: 'auto_skola'
    });
    var user = {
      'ime': req.body.ime,
      'prezime': req.body.prezime,
      'broj_telefona': req.body.broj_telefona,
      'datum_rodjenja': req.body.datum_rodjenja,
      'jmbg': req.body.jmbg,
      'email': req.body.email,
      'sifra': req.body.sifra,
    }
    con.query("INSERT INTO korisnici SET ?", user, function (err, results, fields) {
      if (err) {
        console.log("error ocurred", err);
        res.status(400);
        alerts("Greška prilikom registracije! Molimo vas pokušajte ponovo....");
        res.redirect('/registration');
      } else {
        console.log('The solution is: ', results);
        res.status(200);
        alerts("Uspešna registracija! Sada se možete prijaviti...");
        res.redirect('/login');

      }
    });

});

router.get('/questionOne', function(req, res, next) {
  const con = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    database: 'auto_skola'
  });
  if(req.session.userId==undefined||req.session.userId==0){

      res.redirect('/errorPage');

  }
  else{
    var sql="SELECT count(fk_korisnici) AS brojPokusaja FROM test_stats WHERE fk_korisnici="+req.session.userId;
    con.query(sql,function (errorone,resultone,fieldsone){
      if(resultone[0].brojPokusaja == 5){
        res.redirect('/secondTryError');
      }
      else{
        if (req.session.loggedin) {
          const con = mysql.createConnection({
            host: 'localhost',
            user: 'root',
            database: 'auto_skola'
          });


          console.log(idsPick[0]);
          let sql = "SELECT * FROM b_pitanja WHERE id=" + idsPick[0];
          con.query(sql, function (err, result) {
            //console.log(result);
            res.render('questionOne', {title: "QuestionOne", data: result});
          });
        }
        else{
          res.redirect('/errorPage');
        }
      }
    });
  }
});
router.get('/questionTwo', function(req, res, next) {
  if (req.session.loggedin) {
    const con = mysql.createConnection({
      host: 'localhost',
      user: 'root',
      database: 'auto_skola'
    });


    console.log(idsPick[1]);
    let sql = "SELECT * FROM b_pitanja WHERE id=" + idsPick[1];
    con.query(sql, function (err, result) {
      res.render('questionTwo', {title: "QuestionTwo", data: result});
    });
  }
  else{
    res.redirect('/errorPage');
  }



});
router.get('/questionThree', function(req, res, next) {
  if (req.session.loggedin) {
    const con = mysql.createConnection({
      host: 'localhost',
      user: 'root',
      database: 'auto_skola'
    });

    console.log(idsPick[2]);

    let sql = "SELECT * FROM b_pitanja WHERE id=" + idsPick[2];
    con.query(sql, function (err, result) {
      //console.log(result);
      res.render('questionThree', {title: "QuestionThree", data: result});
    });
  }
  else{
      res.redirect('/errorPage');
    }

});
router.get('/questionFour', function(req, res, next) {
  if (req.session.loggedin) {
    const con = mysql.createConnection({
      host: 'localhost',
      user: 'root',
      database: 'auto_skola'
    });

    console.log(idsPick[3]);

    let sql = "SELECT * FROM b_pitanja WHERE id=" + idsPick[3];
    con.query(sql, function (err, result) {
      //console.log(result);
      res.render('questionFour', {title: "QuestionFour", data: result});
    });
  }
  else{
    res.redirect('/errorPage');
  }


});
router.get('/questionFive', function(req, res, next) {
  if (req.session.loggedin) {
    const con = mysql.createConnection({
      host: 'localhost',
      user: 'root',
      database: 'auto_skola'
    });

    console.log(idsPick[4]);

    let sql = "SELECT * FROM b_pitanja WHERE id=" + idsPick[4];
    con.query(sql, function (err, result) {
      //console.log(result);
      res.render('questionFive', {title: "QuestionFive", data: result});
    });
  }
  else{
    res.redirect('/errorPage');
  }

});


router.post('/answers',upload.none(), function (req,res,next){
  if (req.session.loggedin) {
    const con = mysql.createConnection({
      host: 'localhost',
      user: 'root',
      database: 'auto_skola'
    });


    var answer1 = req.body.answer;
    console.log(answer1);
    var questionId1 = req.body.questionId;
    console.log(questionId1);


    let sql = "SELECT * FROM b_pitanja WHERE id=" + questionId1;
    con.query(sql, function (err, result) {
      console.log(result);
      var odgovor1 = result[0].odgovor;

      if (answer1 === odgovor1) {
        console.log("ODGOVOR JE DOBAR!");
        var stat = {
          "fk_pitanja": questionId1,
          "rezultat": "Tačno",
          "fk_korisnici": req.session.userId //DODAJ IZ SESIJU

        }
        con.query("INSERT INTO test_stats SET ?", stat, function (err, results, fields) {
          if (err) {
            console.log("error ocurred", err);
            res.send({
              "code": 400,
              "failed": "error ocurred"
            });
          } else {
            console.log('The solution is: ', results);
            res.send({
              "code": 200,
              "success": "Uspesno zabelezeno tacno pitanje!"
            });
          }
        });
      } else {
        console.log("odgovor nije dobar!");
        var stat = {
          "fk_pitanja": questionId1,
          "rezultat": "Netačno",
          "fk_korisnici": req.session.userId //DODAJ IZ SESIJU

        }
        con.query("INSERT INTO test_stats SET ?", stat, function (err, results, fields) {
          if (err) {
            console.log("error ocurred", err);
            res.send({
              "code": 400,
              "failed": "error ocurred"
            });
          } else {

            console.log('The solution is: ', results);
            res.send({
              "code": 200,
              "success": "Uspesno zabelezeno netacno pitanje!"
            });


          }

        });

      }
    });
  }
  else{
    res.redirect('/errorPage');
  }

});
router.get('/endTest',function (req,res,next){
  if (req.session.loggedin) {
    const con = mysql.createConnection({
      host: 'localhost',
      user: 'root',
      database: 'auto_skola'
    });

    var sql = "SELECT emailKorisnika("+req.session.userId+") as email, imeKorisnika("+req.session.userId+") as ime,prezimeKorisnika("+req.session.userId+") as prezime," +
        "numberOfCorrectAnswer("+req.session.userId+") as correct,numberOfWrongAnswer("+req.session.userId+") as wrong FROM `test_stats` WHERE fk_korisnici=" +req.session.userId+" GROUP BY fk_korisnici"
    con.query(sql, function (err, result) {
      console.log(result);
      console.log(result[0].correct);
      console.log(result[0].wrong);

      if (result[0].correct == 0) {
        var correct = "0%";
        var stats = "Nije položio!"
      }
      if (result[0].correct == 1) {
        var correct = "20%";
        var stats = "Nije položio!"
      }
      if (result[0].correct == 2) {
        var correct = "40%";
        var stats = "Nije položio!"
      }
      if (result[0].correct == 3) {
        var correct = "60%";
        var stats = "Položio!"
      }
      if (result[0].correct == 4) {
        var correct = "80%";
        var stats = "Položio!"
      }
      if (result[0].correct == 5) {
        var correct = "100%";
        var stats = "Položio!"
      }

      if (result[0].wrong == 0) {
        var wrong = "0%";
      }
      if (result[0].wrong == 1) {
        var wrong = "20%";
      }
      if (result[0].wrong == 2) {
        var wrong = "40%";
      }
      if (result[0].wrong == 3) {
        var wrong = "60%";
      }
      if (result[0].wrong == 4) {
        var wrong = "80%";
      }
      if (result[0].wrong == 5) {
        var wrong = "100%";
      }
      var dataOne = [];
      var dataJson =
          {
            'correctA': correct,
            'wrongA': wrong,
            'stats': stats,
          }

      dataOne.push(dataJson);
      console.log(dataOne);


      res.render('testResult', {title: "Result", data: result, dataA: dataOne});
    });
  }
  else{
    res.redirect('/errorPage');
  }

  
});

module.exports = router;
