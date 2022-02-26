import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_heat/widgets/heat_map.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  DateTime currentDate = DateTime.now();
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 236, 12, 12),
      Color.fromARGB(255, 255, 148, 7)
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  @override
  Widget build(BuildContext context) {
    String month = DateFormat('MMM').format(currentDate);

    return SafeArea(
      child: Scaffold(
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
                  child: Text(month),
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
                  child: HeatMaps()),
            )
          ]),
        ),
      ),
    );
  }
}
