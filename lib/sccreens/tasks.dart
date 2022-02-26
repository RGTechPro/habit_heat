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
             Text(
                        '0 Task today',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.black54,
                            fontSize: 17),
                      ),
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
           Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: LinearPercentIndicator(
                          padding: EdgeInsets.only(right: 10),
                          trailing: Text(
                            '69%',
                            style: TextStyle(
                                fontFamily: 'Roboto', color: Colors.black54),
                          ),
                          percent: .69,
                          lineHeight: 3,
                          backgroundColor: Colors.grey.withOpacity(.2),
                          linearGradient: LinearGradient(
                              colors: widget.color!,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                        ),
                      ),
            Text(
              'Today',
              style: TextStyle(
                  fontFamily: 'Roboto', color: Colors.black54, fontSize: 17),
            ),
            Center(
                        child: Text(
                          'No task found for today!',
                          textAlign: TextAlign.center,
                        ),
                      ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'Tommorrow',
                style: TextStyle(
                    fontFamily: 'Roboto', color: Colors.black54, fontSize: 17),
              ),
            ),
          Center(
                        child: Text(
                          'No task found for today!',
                          textAlign: TextAlign.center,
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
