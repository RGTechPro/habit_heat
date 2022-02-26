import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_heat/Provider/task.dart';
import 'package:habit_heat/constants/size_config.dart';
import 'package:habit_heat/sccreens/activity_page.dart';
import 'package:habit_heat/sccreens/tasks.dart';
import 'package:habit_heat/widgets/heat_map.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatelessWidget {
  String? profile;
  IconData? icon;
  int? task_done;
  int? total_task;
  List<Color>? color;

  TaskCard(
      {this.profile, this.icon, this.task_done, this.total_task, this.color});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 15, left: 2, bottom: 20),
      child: GestureDetector(
        onTap: () {
          Provider
              .of<TaskData>(context, listen: false)
              .profile = profile;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ActivityPage()));
        },
        child: Container(
          height: SizeConfig.screenHeight! * 0.46,
          width: SizeConfig.screenWidth! * 0.7,
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text('0 Task today',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.black54,
                        fontSize: 22),
                  ),
                ),
                HeatMaps(date:DateTime.now(),abcd: false,),
                // Expanded(
                //   child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Container(
                //             decoration: BoxDecoration(
                //                 shape: BoxShape.circle,
                //                 border: Border.all(
                //                     color: Colors.grey.withOpacity(.15))),
                //             child: Padding(
                //               padding: const EdgeInsets.all(10),
                //               child: Icon(
                //                 icon,
                //                 color: color!.first,
                //               ),
                //             ),
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.all(8),
                //           child: Icon(
                //             Icons.more_vert,
                //             color: Colors.grey.withOpacity(0.5),
                //           ),
                //         ),
                //       ]),
                // ),
                // SizedBox(
                //   height: SizeConfig.screenHeight! * 0.22,
                // ),
                // Padding(
                //             padding: const EdgeInsets.symmetric(
                //                 horizontal: 8.0, vertical: 3),
                //             child: Text(
                //               '0 Task today',
                //               style: TextStyle(
                //                   fontFamily: 'Roboto',
                //                   color: Colors.black54,
                //                   fontSize: 17),
                //             ),
                //           ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8),
                //   child: Text(
                //     profile!,
                //     style: TextStyle(
                //         fontFamily: 'Roboto',
                //         fontWeight: FontWeight.bold,
                //         color: Colors.black54,
                //         fontSize: 30),
                //   ),
                // ),
                // SizedBox(
                //   height: SizeConfig.screenHeight! * 0.020,
                // ),
                // LinearPercentIndicator(
                //   //  padding: EdgeInsets.only(right: 10),
                //   trailing: Text(
                //     '69%',
                //     style: TextStyle(
                //         fontFamily: 'Roboto', color: Colors.black54),
                //   ),
                //   percent: 0.69,
                //   lineHeight: 3,
                //   backgroundColor: Colors.grey.withOpacity(.2),
                //   linearGradient: LinearGradient(
                //       colors: color!,
                //       begin: Alignment.centerLeft,
                //       end: Alignment.centerRight),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
