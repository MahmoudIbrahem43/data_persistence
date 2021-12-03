import 'package:data_persistence/model/course.dart';
import 'package:data_persistence/pages/courseDetails.dart';
import 'package:flutter/material.dart';
import '../dbhelper.dart';
import 'courseUpdate.dart';
import 'newCourse.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper helper;
  TextEditingController teSearch = TextEditingController();
  var allCourses = [];
  var items = [];

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    helper.allCourses().then((courses) {
      setState(() {
        allCourses = courses;
        items = allCourses;
      });
    });
  }

  //search and filter function
  void filterSearch(String query) {
    var dummySearchList = allCourses;
    if (query.isNotEmpty) {
      var dummyListData = [];
      dummySearchList.forEach((item) {
        var course = Course.fromMap(item);
        if (course.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
        setState(() {
          items = [];
          items.addAll(dummyListData);
        });
      });
      return;
    } else {
      setState(() {
        items = [];
        items = allCourses;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SQLite Database'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => NewCourse())),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    filterSearch(value);
                  });
                },
                controller: teSearch,
                decoration: InputDecoration(
                    hintText: 'Search...',
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    )),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, i) {
                    Course course = Course.fromMap(items[i]);
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: ListTile(
                        title: Text('${course.name} - ${course.hours} Hours'),
                        subtitle: Text(course.content),
                        trailing: Column(
                          children: <Widget>[
                            Expanded(
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    helper.deleteCourse(course.id);
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                icon: Icon(
                                  Icons.update,
                                  color: Colors.green,
                                ),
                                onPressed: () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CourseUpdate(course),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CourseDetails(course)));
                        },
                      ),
                    );
                  }),
            )
          ],
        )

        // FutureBuilder(
        //   future: helper.allCourses(),
        //   builder: (context, AsyncSnapshot snapshot) {
        //     if (!snapshot.hasData) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     } else {
        //       return
        //
        //     }
        //   },
        // ),
        );
  }
}
