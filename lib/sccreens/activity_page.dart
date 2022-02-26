import 'package:flutter/material.dart';
import 'package:habit_heat/widgets/heat_map.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [Container(
            
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
            
            child: HeatMaps())]),
        ),
      ),
    );
  }
}
