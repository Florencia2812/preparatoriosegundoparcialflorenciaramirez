import 'package:flutter/material.dart';
import 'apiservice.dart';
import 'student.dart';
import 'editstudent.dart';

class StudentDetails extends StatefulWidget {
  Student student;
  StudentDetails(this.student);

  @override
  _StudentDetailsState createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    int id = widget.student.studentID;
    return Scaffold(
      backgroundColor: Colors.pinkAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent[200],
        title: Text("Student details"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: 440.0,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    children: [
                      Text(
                        "Last Name: ",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.student.lastName,
                        style: TextStyle(fontSize: 25.0),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(30, 30, 30, 30.0),
                  child: Column(
                    children: [
                      Text(
                        'Enrollment Date: ',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        widget.student.enrollmentDate.toString(),
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(70, 50, 0, 10),
                  child: Row(
                    children: [
                      RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditStudent(widget.student),
                              ),
                            );
                          },
                          color: Colors.pinkAccent[200],
                          child: Icon(
                            Icons.create_outlined,
                            color: Colors.cyanAccent,
                            size: 30.0,
                          )),
                      SizedBox(
                        width: 35.0,
                      ),
                      RaisedButton(
                        onPressed: () {
                          apiService.deleteStudent(widget.student.studentID);
                          Navigator.pop(context);
                        },
                        color: Colors.pinkAccent[200],
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.cyanAccent,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
