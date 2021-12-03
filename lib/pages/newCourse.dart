import 'package:data_persistence/model/course.dart';
import 'package:flutter/material.dart';
import '../dbhelper.dart';

class NewCourse extends StatefulWidget {
  @override
  _NewCourseState createState() => _NewCourseState();
}

class _NewCourseState extends State<NewCourse> {
  String name, content;
  int hours;
  DbHelper helper;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(hintText: 'Enter Course name'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(
                height: 2,
              ),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(hintText: 'Enter Course Content'),
                onChanged: (value) {
                  setState(() {
                    content = value;
                  });
                },
              ),
              SizedBox(
                height: 2,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Enter Course hours'),
                onChanged: (value) {
                  setState(() {
                    hours = int.parse(value);
                  });
                },
              ),
              // SizedBox(
              //   height: 2,
              // ),
              RaisedButton(
                child: Text('Save'),
                onPressed: () async {
                  var course = Course(
                      {'name': name, 'content': content, 'hours': hours});
                  int id = await helper.createCourse(course);
                  print('course id is $id');
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
