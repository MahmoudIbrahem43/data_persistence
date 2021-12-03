import 'package:data_persistence/dbhelper.dart';
import 'package:data_persistence/model/course.dart';
import 'package:flutter/material.dart';

class CourseUpdate extends StatefulWidget {
  Course course;
  CourseUpdate(this.course);

  @override
  _CourseUpdateState createState() => _CourseUpdateState();
}

class _CourseUpdateState extends State<CourseUpdate> {
  TextEditingController teName = TextEditingController();
  TextEditingController teContent = TextEditingController();
  TextEditingController teHoures = TextEditingController();
  DbHelper helper;

  @override
  void initState() {
    super.initState(); //show data before editing
    helper = DbHelper();
    teName.text = widget.course.name;
    teContent.text = widget.course.content;
    teHoures.text = widget.course.hours.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('course update'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: teName,
            ),
            TextField(
              maxLines: 5,
              controller: teContent,
            ),
            TextField(
              controller: teHoures,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('save'),
              onPressed: () async {
                Course updatedCourse = Course({
                  'id': widget.course.id,
                  'name': teName.text,
                  'content': teContent.text,
                  'hours': int.parse(teHoures.text),
                });
                await helper.courseUpdate(updatedCourse);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
