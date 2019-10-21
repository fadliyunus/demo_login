import 'dart:convert';

import 'package:demo_login/viuw.ui/home.dart';
import 'package:demo_login/viuw.ui/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _usernameController = TextEditingController();
  var _passwordController =TextEditingController();
  var _isSecured = true;
  var data;

  @override
  Widget build(BuildContext context) {


 /****** Get Login Connection && Data ********/
    Future<String> getLogin(String username) async {
      var response = await http.get(
          Uri.encodeFull(
              "http://10.0.2.2/fluttercrud/Login.php?PSEUDO=${username}"),
          headers: {"Accept": "application/json"});

      print(response.body);
      print(username);
      setState(() {
        var convertDataToJson = json.decode(response.body);
        data = convertDataToJson['result'];
      });
    }


//******** create account *********
var createaccount =   Container(
      child: RaisedButton(
        child: Text('Register'.toUpperCase(),style: TextStyle(color: Colors.white),),
        // splashColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
        color: Theme.of(context).accentColor,
        onPressed: () {
          var route =   MaterialPageRoute(
            builder: (BuildContext context) =>  Register(),
          );
          Navigator.of(context).push(route);
        },
      ),
    );

//******** edittext username */
var username = new ListTile(
      leading: const Icon(Icons.person),
      title: TextFormField(
        decoration: InputDecoration(
            labelText: "your username",
            filled: true,
            hintText: "Write your username please",
            border: InputBorder.none),
        controller: _usernameController,
      ),
    );

     /******* edittext Password ***********/
    var password = ListTile(
      leading: const Icon(Icons.lock),
      title: TextField(
        decoration: InputDecoration(
            icon: IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                ),
                onPressed: () {
                  setState(() {
                    _isSecured = !_isSecured;
                  });
                }),
            labelText: "your Password",
            hintText: "Write your Password please",
            border: InputBorder.none),
        obscureText: _isSecured,
        controller: _passwordController,
      ),
    );

  /*******Button Cancel ********/
    var cancelButton = Container(
      child: FlatButton(
        child: Text('Cancel'.toUpperCase(),style: TextStyle(color: Colors.black)),
        onPressed: () {
          _passwordController.clear();
          _usernameController.clear();
        },
      ),
    );

 /******* Button Login**************/
    var loginButton = new Container(
      child: RaisedButton(
        child: Text('LogIn'.toUpperCase(),style: TextStyle(color: Colors.white)),
        color: Theme.of(context).accentColor,
        elevation: 8.0,
        splashColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
        onPressed: () {
          getLogin(_usernameController.text);
          VerifData(_usernameController.text, _passwordController.text, data);
        },
      ),
    );

    return  Scaffold(
      backgroundColor: Colors.cyan,
      body:  ListView(
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          logo,
          SizedBox(
            height: 50.0,
          ),
           Padding(
            padding: const EdgeInsets.all(20.0),
            child:   Card(
              elevation: 8.0,
              color: Colors.white,
              child:   Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: <Widget>[username, password,
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[cancelButton, loginButton],
                  ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0,),
          createaccount
        ],
      ),
    );
  }
  /********Alert Dialog Username***********/
    void onSignedInErrorUsername() {
      var alert = new AlertDialog(
        title: new Text("Username Error"),
        content:
            new Text("There was an USername error signing in. Please try again."),
      );
      showDialog(context: context, child: alert);
    }
  /********Alert Dialog Password***********/
    void onSignedInErrorPassword() {
      var alert = new AlertDialog(
        title: new Text("Password Error"),
        content: new Text(
            "There was an Password error signing in. Please try again."),
      );
      showDialog(context: context, child: alert);
    }
  /******* Check Data ||Validasi **********/
    VerifData(String username, String password, var data) {
      if (data[0]['username'] == username) {
        if (data[0]['password'] == password) {
          // Navigator.of(context).pushNamed("/seconds");

          var route = MaterialPageRoute(
            builder: (BuildContext context) =>
                HalamanUtama(idUser: data[0]['user_id'],
                firstname: data[0]['first_name'],
                lastname: data[0]['last_name'],
                username: data[0]['username'],),
          );
          Navigator.of(context).push(route);
        } else {
          onSignedInErrorPassword();
        }
      } else {
        onSignedInErrorUsername();
      }
    }
  //tampilan logo
   var logo =   Center(
      child:   Container(
        width: 300.0,
        height: 200.0,
        decoration:   BoxDecoration(
          shape: BoxShape.circle,
          image:   DecorationImage(
              fit: BoxFit.fill,
              image:   NetworkImage("http://www.digital-wave.com/images/dart-logo.png")),
        ),
      ),
    );

   
    
}