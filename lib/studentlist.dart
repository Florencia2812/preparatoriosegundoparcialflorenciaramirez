import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'apiservice.dart';
import 'student.dart';
import 'details.dart';

class StudentListView extends StatelessWidget {
  final ApiService apiService = ApiService();
  SharedPreferences sharedPreferences;

  refreshState() {
    StudentListView();
  }

  @override
  Widget build(BuildContext context) {
    ListTile _tile(
        int id, String lastName, String firstName, DateTime enrollmentDate) {
      Student student =
          Student.newStudent(id, lastName, firstName, enrollmentDate);
      return ListTile(
        title: Text(
          firstName + ' ' + lastName,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
        subtitle: Text(
          'ID: ' + id.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
        leading: Icon(
          Icons.person_sharp,
          color: Colors.cyanAccent,
          size: 30.0,
        ),
        onTap: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StudentDetails(student)))
              .then((value) => refreshState());
        },
      );
    }

    ListView _studentsListView(data) {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(
            data[index].studentID,
            data[index].lastName,
            data[index].firstName,
            data[index].enrollmentDate,
          );
        },
      );
    }

    return FutureBuilder<List<Student>>(
      future: apiService.getStudents(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Student> data = snapshot.data;
          return _studentsListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
