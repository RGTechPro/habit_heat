import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_heat/model/FAQ.dart';
import 'package:habit_heat/sccreens/add_session.dart';
import 'package:habit_heat/widgets/faq_widget.dart';
import 'package:habit_heat/widgets/heat_map.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

import '../Provider/currentState.dart';

class ActivityPage extends StatefulWidget {
  int index;
  ActivityPage({Key? key, required this.index}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  DateTime currentDate = DateTime.now();
  var color = [Color(0xff4cc1a9), Color(0xff378e7c)];
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 236, 12, 12),
      Color.fromARGB(255, 255, 148, 7)
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  final Gradient grad = LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 236, 12, 12),
      Color.fromARGB(255, 255, 148, 7)
    ],
    //  GColors = [Color(0xff4cc1a9), Color(0xff378e7c)];
  );
  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of(context,listen: false);

    String month = DateFormat('yMMM').format(currentDate);

    return SafeArea(
      child: Scaffold(
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
                      colors: color,
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft))),
          onPressed: () {
            // Provider.of<TaskData>(context, listen: false).profile =
            //     widget.profile;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddSession(
                          color: color,
                          profile: 'Gym',
                        )));
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FaIcon(
                  FontAwesomeIcons.fire,
                  color: Colors.orange,
                ),
                Text(
                  'HeatMap',
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()..shader = linearGradient),
                ),
                GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: grad,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset.zero,
                                spreadRadius: 0,
                                blurRadius: 13),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border:
                              Border.all(color: Colors.grey.withOpacity(.01))),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          month,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                  onTap: () {
                    showMonthPicker(context: context, initialDate: currentDate)
                        .then((date) {
                      if (date != null) {
                        setState(() {
                          currentDate = date;
                        });
                      }
                    });
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset.zero,
                            spreadRadius: 0,
                            blurRadius: 13),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.grey.withOpacity(.01))),
                  child: HeatMaps(
                    date: currentDate,
                    abcd: true,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Today's sessions",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: grad,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset.zero,
                            spreadRadius: 0,
                            blurRadius: 13),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.grey.withOpacity(.01))),
                  child: ListView.builder(
                      itemCount: _instance.currentUser.habits?[widget.index].sessions?.length ?? 0,
                      itemBuilder: (context, int n) {
                        return FAQWidget(
                            faq: FAQ(
                                question: 'Session #1',
                                answer:
                                    'Rating: ${_instance.currentUser.habits?[widget.index].sessions?[n].rating}\nDuration: ${_instance.currentUser.habits?[widget.index].sessions?[n].duration} hrs\nRemarks: ${_instance.currentUser.habits?[widget.index].sessions?[n].remarks}'));
                      }),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
