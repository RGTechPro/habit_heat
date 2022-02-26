import 'package:flutter/material.dart';
import 'package:habit_heat/widgets/faq_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/FAQ.dart';

class DateDialog extends StatefulWidget {
  DateDialog({required this.sessionList, required this.date});
  final List<FAQ> sessionList;
  final DateTime date;
  @override
  State<DateDialog> createState() => _DateDialogState();
}

class _DateDialogState extends State<DateDialog> {
  FocusNode nameFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 236, 12, 12),
      Color.fromARGB(255, 255, 148, 7)
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  final Gradient grad = LinearGradient(
    colors: <Color>[
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 255, 255, 254)
    ],
  );
  @override
  Widget build(BuildContext context) {
//    final accountProvider = Provider.of<Account>(context, listen: false);
    var color = [
      Color.fromARGB(255, 236, 12, 12),
      Color.fromARGB(255, 255, 148, 7)
    ];
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 50,
      child: Container(
        height: 400,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                DateFormat('dd MMM yyyy').format(widget.date),
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    //   color: Colors.deepOrange,
                    foreground: Paint()..shader = linearGradient),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.sessionList.length,
                  itemBuilder: (context, int n) {
                    return FAQWidget(
                        faq: FAQ(
                            question: widget.sessionList[n].question,
                            answer: widget.sessionList[n].answer));
                  }),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Go Back',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: color,
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.grey.withOpacity(.01)))),
            )
          ],
        ),
      ),
    );
  }
}
