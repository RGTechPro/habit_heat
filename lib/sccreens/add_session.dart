import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:habit_heat/Provider/currentState.dart';

// import 'package:habit_heat/services/add_task.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:duration_picker/duration_picker.dart';
import 'package:provider/provider.dart';

class AddSession extends StatefulWidget {
  AddSession({this.color, this.profile});

  List<Color>? color;
  String? profile;

  @override
  _AddSessionState createState() => _AddSessionState();
}

class _AddSessionState extends State<AddSession> {
  final _formKey = GlobalKey<FormState>();
  Duration duration = Duration(hours: 0, minutes: 0);
  String init_val = 'Today';

  // String? taskName;
  int ratings = 0;
  String? remarks;

  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context,listen:false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'New Session',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              color: Colors.black54),
        ),
        iconTheme: IconThemeData(color: Colors.black45),
        leading: Padding(
          padding: const EdgeInsets.all(11.0),
          child: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Please fill below details',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black54,
                                fontSize: 22)),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text('Rating for the session:',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 15)),
                        ),
                        RatingBar.builder(
                          initialRating: 3,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            switch (index) {
                              case 0:
                                return Icon(
                                  Icons.sentiment_very_dissatisfied,
                                  color: Colors.red,
                                );
                              case 1:
                                return Icon(
                                  Icons.sentiment_dissatisfied,
                                  color: Colors.redAccent,
                                );
                              case 2:
                                return Icon(
                                  Icons.sentiment_neutral,
                                  color: Colors.amber,
                                );
                              case 3:
                                return Icon(
                                  Icons.sentiment_satisfied,
                                  color: Colors.lightGreen,
                                );
                              case 4:
                                return Icon(
                                  Icons.sentiment_very_satisfied,
                                  color: Colors.green,
                                );
                              default:
                                return Icon(Icons.star);
                            }
                          },
                          onRatingUpdate: (rating) {
                            ratings = rating.toInt();
                            print(rating);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text('Duration for the session:',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black54,
                                  fontSize: 15)),
                        ),
                        DurationPicker(
                          duration: duration,
                          onChange: (val) {
                            setState(() => duration = val);
                          },
                          snapToMins: 5.0,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            remarks = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter the remark ';
                            }
                          },

                          style: TextStyle(fontSize: 30),
                          cursorColor: Colors.grey,
                          cursorHeight: 30,
                          autofocus: true,
                          decoration: InputDecoration(border: InputBorder.none,
                          hintText: "Remarks for the Session"),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(.2),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.work,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              _instance.currentUser.habits?[_instance.selected].name ?? "",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.grey.withOpacity(.2),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(DateTime.now().toString()),
                          ],
                        ),
                        // Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  // String? date;
                  // if (init_val == 'Today') {
                  //   final now = new DateTime.now();
                  //   date = DateFormat.yMMMMd('en_US').format(now);
                  // } else if (init_val == 'Tommorrow') {
                  //   var now = new DateTime.now();
                  //   var t = now.add(new Duration(days: 1));
                  //   date = DateFormat.yMMMMd('en_US').format(t);
                  // }
                  // await addTask(context, taskName!, date!, false);

                  if (duration == Duration(hours: 0, minutes: 0)) {
                    Fluttertoast.showToast(
                        msg: "This is Center Short Toast",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                }
              },
              child: GestureDetector(
                onTap: () {
                  _instance.addSession(rating: ratings, duration: duration.inMinutes);
                },
                child: Container(
                    height: 50,
                    width: double.infinity,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: widget.color!,
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
