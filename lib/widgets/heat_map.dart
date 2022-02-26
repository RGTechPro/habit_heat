import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_heat/model/FAQ.dart';
import 'package:habit_heat/sccreens/activity_page.dart';
import 'package:habit_heat/widgets/dialog_box.dart';

class HeatMaps extends StatefulWidget {
  HeatMaps({required this.date, required this.abcd});
  DateTime date;
  bool abcd;
  @override
  State<HeatMaps> createState() => _HeatMapsState();
}

class _HeatMapsState extends State<HeatMaps> {
  @override
  Widget build(BuildContext context) {
    print(widget.date);
    //var date = DateTime.now();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: HeatMap(
        endDate: (DateTime.now().month == widget.date.month)
            ? DateTime.now()
            : DateTime(widget.date.year, widget.date.month + 1, 0),
        defaultColor: Color(0xffeeeeef),
        size: 33,
        margin: EdgeInsets.all(3.5),
        textColor: Colors.black54,
        startDate: DateTime(widget.date.year, widget.date.month, 1),
        datasets: {
          DateTime(2022, 2, 6): 3,
          DateTime(2022, 2, 7): 7,
          DateTime(2022, 2, 8): 10,
          DateTime(2022, 2, 9): 13,
          DateTime(2022, 2, 13): 6,
        },
        colorMode: ColorMode.opacity,
        //  borderRadius: 50,
        showText: false,
        scrollable: true,
        colorsets: {
          1: Colors.green,
        },
        onClick: (value) async {
          if (widget.abcd == true) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(value.toString())));
            await showDialog(
                context: context,
                builder: (_) => DateDialog(
                      sessionList: [
                        FAQ(
                            question: 'Session #1',
                            answer:
                                'Rating: 4\nDuration: 4 hrs\nRemarks: abcdefjhv'),
                        FAQ(
                            question: 'Session #1',
                            answer:
                                'Rating: 4\nDuration: 4 hrs\nRemarks: abcdefjhv'),
                        FAQ(
                            question: 'Session #1',
                            answer:
                                'Rating: 4\nDuration: 4 hrs\nRemarks: abcdefjhv')
                      ],
                      date: value,
                    ));
            setState(() {});
          }
          else{

                     Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ActivityPage()));
          }
        },
      ),
    );
  }
}
