import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_heat/Provider/task.dart';
import 'package:habit_heat/model/task.dart';
import 'package:habit_heat/sccreens/add_task.dart';
import 'package:habit_heat/widgets/task_tile.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class Task extends StatefulWidget {
  Task({this.profile, this.icon, this.task_done, this.total_task, this.color});
  String? profile;
  IconData? icon;
  int? task_done;
  int? total_task;
  List<Color>? color;
  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  // int len = 0;
  // int n = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Container(
            width: 60,
            height: 60,
            child: Icon(
              Icons.add,
              size: 40,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: widget.color!,
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft))),
        onPressed: () {
          Provider.of<TaskData>(context, listen: false).profile =
              widget.profile;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTask(
                        color: widget.color,
                        profile: widget.profile,
                      )));
        },
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black45),
        actions: [
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          )
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 45, left: 40, right: 40),
        child: ListView(
          //
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Colors.grey.withOpacity(.15))),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        widget.icon,
                        color: widget.color!.first,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(widget.profile!)
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  try {
                    final now = new DateTime.now();
                    String date = DateFormat.yMMMMd('en_US').format(now);
                    List tempDoc = snapshot.data![date];
                    if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        'Something went wrong',
                      ));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (tempDoc.isEmpty) {
                      return Text(
                        '0 Task today',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.black54,
                            fontSize: 17),
                      );
                    }

                    Provider.of<TaskData>(context).len = tempDoc.length;

                    return Text(
                      '${Provider.of<TaskData>(context).len} Tasks today',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black54,
                          fontSize: 17),
                    );
                  } catch (e) {
                    if (e.toString().contains('field does not exist') ||
                        e.toString().contains('cannot get a field')) {
                      return Text(
                        '0 Task today',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.black54,
                            fontSize: 17),
                      );
                    }
                    return Center(
                        child: Text(
                      'Error: $e',
                      textAlign: TextAlign.center,
                    ));
                  }
                }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                widget.profile!,
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 30),
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(widget.profile!)
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  try {
                    final now = new DateTime.now();
                    String date = DateFormat.yMMMMd('en_US').format(now);
                    List tempDoc = snapshot.data![date];
                    if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        'Something went wrong',
                      ));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (tempDoc.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: LinearPercentIndicator(
                          padding: EdgeInsets.only(right: 10),
                          trailing: Text(
                            '0%',
                            style: TextStyle(
                                fontFamily: 'Roboto', color: Colors.black54),
                          ),
                          percent: 0,
                          lineHeight: 3,
                          backgroundColor: Colors.grey.withOpacity(.2),
                          linearGradient: LinearGradient(
                              colors: widget.color!,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                        ),
                      );
                    }

                    Provider.of<TaskData>(context).len = tempDoc.length;
                    Provider.of<TaskData>(context).n = 0;
                    for (int i = 0;
                        i < Provider.of<TaskData>(context, listen: false).len;
                        i++) {
                      if (tempDoc[i]['isDone'] == true) {
                        Provider.of<TaskData>(context).n++;
                      }
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: LinearPercentIndicator(
                        padding: EdgeInsets.only(right: 10),
                        trailing: Text(
                          '${(Provider.of<TaskData>(context).n / Provider.of<TaskData>(context).len * 100).toStringAsFixed(2)}%',
                          style: TextStyle(
                              fontFamily: 'Roboto', color: Colors.black54),
                        ),
                        percent: Provider.of<TaskData>(context).n /
                            Provider.of<TaskData>(context).len,
                        lineHeight: 3,
                        backgroundColor: Colors.grey.withOpacity(.2),
                        linearGradient: LinearGradient(
                            colors: widget.color!,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                      ),
                    );
                  } catch (e) {
                    if (e.toString().contains('field does not exist') ||
                        e.toString().contains('cannot get a field')) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: LinearPercentIndicator(
                          padding: EdgeInsets.only(right: 10),
                          trailing: Text(
                            '0%',
                            style: TextStyle(
                                fontFamily: 'Roboto', color: Colors.black54),
                          ),
                          percent: 0,
                          lineHeight: 3,
                          backgroundColor: Colors.grey.withOpacity(.2),
                          linearGradient: LinearGradient(
                              colors: widget.color!,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                        ),
                      );
                    }
                    return Center(
                        child: Text(
                      'Error: $e',
                      textAlign: TextAlign.center,
                    ));
                  }
                }),
            Text(
              'Today',
              style: TextStyle(
                  fontFamily: 'Roboto', color: Colors.black54, fontSize: 17),
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(widget.profile!)
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      'Something went wrong',
                    ));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  try {
                    final now = new DateTime.now();
                    String date = DateFormat.yMMMMd('en_US').format(now);
                    List tempDoc = snapshot.data![date];
                    // List<Tasks> tempList = [];
                    // for (int i = 0; i < tempDoc.length; i++) {
                    //   tempList.insert(
                    //       0,
                    //       Tasks(taskName: tempDoc[i]['taskName'],
                    //       isDone: tempDoc[i]['isDone']
                    //          ));
                    // }
                    // Provider.of<TaskData>(context).len = tempDoc.length;

                    // for (int i = 0;
                    //     i < Provider.of<TaskData>(context, listen: false).len;
                    //     i++) {
                    //   if (tempDoc[i]['isDone'] == true) {
                    //     Provider.of<TaskData>(context).n++;
                    //   }
                    // }
                    // Provider.of<TaskData>(context, listen: false).call();

                    if (tempDoc.isEmpty) {
                      return Center(
                        child: Text(
                          'No task found for today!',
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: tempDoc.length,
                      itemBuilder: (context, index) {
                        return TaskTile(
                          taskName: tempDoc[index]['taskName'],
                          isDone: tempDoc[index]['isDone'],
                          Dcontext: context,
                          day: 'Today',
                        );
                      },
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                    );
                  } catch (e) {
                    if (e.toString().contains('field does not exist') ||
                        e.toString().contains('cannot get a field')) {
                      return Center(
                        child: Text(
                          'No task found for today!',
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return Center(
                        child: Text(
                      'Error: $e',
                      textAlign: TextAlign.center,
                    ));
                  }
                }),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'Tommorrow',
                style: TextStyle(
                    fontFamily: 'Roboto', color: Colors.black54, fontSize: 17),
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection(widget.profile!)
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      'Something went wrong',
                    ));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  try {
                    var now = new DateTime.now();
                    var t = now.add(new Duration(days: 1));
                    String date = DateFormat.yMMMMd('en_US').format(t);
                    List tempDoc = snapshot.data![date];

                    // List<Tasks> tempList = [];
                    // for (int i = 0; i < tempDoc.length; i++) {
                    //   tempList.insert(
                    //       0,
                    //       Tasks(taskName: tempDoc[i]['taskName'],
                    //       isDone: tempDoc[i]['isDone']
                    //          ));
                    // }
                    if (tempDoc.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'No task found!',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: tempDoc.length,
                      itemBuilder: (context, index) {
                        return TaskTile(
                          taskName: tempDoc[index]['taskName'],
                          isDone: tempDoc[index]['isDone'],
                          Dcontext: context,
                          day: 'Tommorrow',
                        );
                      },
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                    );
                  } catch (e) {
                    if (e.toString().contains('field does not exist') ||
                        e.toString().contains('cannot get a field')) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'No task found for tommorrow!',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    return Center(
                        child: Text(
                      'Error: $e',
                      textAlign: TextAlign.center,
                    ));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
