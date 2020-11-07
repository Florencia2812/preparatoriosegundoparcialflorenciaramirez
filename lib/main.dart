import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'addstudent.dart';
import 'package:preparatoriosegundoparcialflorenciaramirez/studentlist.dart';

void main() => runApp(StudentSecurity());

class StudentSecurity extends StatelessWidget {
  const StudentSecurity({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Florencia's Student App",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent[200],
        shadowColor: Colors.deepPurpleAccent[200],
        title: Text(
          "Students App",
          style: TextStyle(color: Colors.cyan[200]),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              // ignore: deprecated_member_use
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                  (Route<dynamic> route) => false);
            },
            child: Text(
              "Log Out",
              style: TextStyle(color: Colors.cyan),
            ),
          ),
        ],
      ),
      body: Center(
        child: StudentListView(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Icon(
          Icons.person_add_alt_1_outlined,
          color: Colors.pinkAccent[150],
          size: 30.0,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddStudent()),
          );
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
    return scaffold;
  }
}
