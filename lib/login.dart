import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.pink[100], Colors.white10],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: _isLoading
                ? Center(child: LinearProgressIndicator())
                : ListView(
                    children: <Widget>[
                      headerSection(),
                      textSection(),
                      buttonSection(),
                    ],
                  )));
  }

  Container headerSection() {
    return Container(
      margin: EdgeInsets.only(
        top: 40.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text(
        "Student",
        style: TextStyle(
            color: Colors.cyanAccent,
            fontSize: 40.0,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.cyan[300],
            style: TextStyle(color: Colors.pink[200]),
            decoration: InputDecoration(
                icon: Icon(
                  Icons.attach_email_outlined,
                  color: Colors.pinkAccent[300],
                ),
                hintText: "Email",
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purpleAccent[200]),
                ),
                hintStyle: TextStyle(color: Colors.cyan[200])),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.pinkAccent[100],
            obscureText: true,
            style: TextStyle(color: Colors.pink[200]),
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_clock,
                  color: Colors.pinkAccent[300],
                ),
                hintText: "Password",
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purpleAccent[200]),
                ),
                hintStyle: TextStyle(color: Colors.cyan[200])),
          )
        ],
      ),
    );
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                signIn(emailController.text, passwordController.text);
              },
        elevation: 10.0,
        color: Colors.pink[100],
        child: Text(
          "Sign In",
          style: TextStyle(color: Colors.cyan[200]),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  signIn(String email, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'grant_type': 'password', 'username': email, 'password': pass};
    var jsonResponse;
    var response = await http.post(
      "https://appserviceflorencia.azurewebsites.net/token",
      body: data,
    );
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['access_token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Home()),
            (Route<dynamic> route) => false);
      }
    }
  }
}
