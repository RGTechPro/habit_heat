import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HeatMaps extends StatelessWidget {
  const HeatMaps({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: HeatMap(
        defaultColor: Color(0xffeeeeef),
        size: 33,
        margin: EdgeInsets.all(3.5),
        textColor: Colors.black54,
        startDate: DateTime(date.year, date.month - 1, date.day),
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
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
