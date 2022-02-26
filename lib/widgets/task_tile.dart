import 'package:flutter/material.dart';
// import 'package:habit_heat/services/delete_task.dart';
// import 'package:habit_heat/services/edit_task.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatefulWidget {
  TaskTile({this.taskName, this.isDone = false, this.Dcontext, this.day});
  String? taskName;
  bool? isDone;
  String? day;
  BuildContext? Dcontext;

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    bool checkedValue = widget.isDone!;
    return ListTile(
      trailing: (checkedValue)
          ? GestureDetector(
              onTap: () async {
                // String? date;
                // if (widget.day == 'Today') {
                //   final now = new DateTime.now();
                //   date = DateFormat.yMMMMd('en_US').format(now);
                // } else if (widget.day == 'Tommorrow') {
                //   var now = new DateTime.now();
                //   var t = now.add(new Duration(days: 1));
                //   date = DateFormat.yMMMMd('en_US').format(t);
                // }

                // await deleteTask(
                //     widget.Dcontext!, widget.taskName!, date!, widget.isDone!);
              },
              child: Icon(
                Icons.delete,
                color: Colors.black45,
              ),
            )
          : null,
      contentPadding: EdgeInsets.all(0),
      visualDensity: VisualDensity(horizontal: -4, vertical: -2),
      title: Text(
        widget.taskName!,
        style: TextStyle(
            decoration: (checkedValue)
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            fontFamily: 'Roboto',
            color: Colors.black54,
            fontSize: 17),
      ),
      leading: Checkbox(
        fillColor: MaterialStateProperty.all(Colors.black45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        visualDensity: VisualDensity(horizontal: -4),
        value: checkedValue,
        onChanged: (a) {
          setState(() {
            (!checkedValue) ? checkedValue = true : checkedValue = false;

            String? date;
            if (widget.day == 'Today') {
              final now = new DateTime.now();
              date = DateFormat.yMMMMd('en_US').format(now);
            } else if (widget.day == 'Tommorrow') {
              var now = new DateTime.now();
              var t = now.add(new Duration(days: 1));
              date = DateFormat.yMMMMd('en_US').format(t);
            }

            // editTask(
            //     context, widget.taskName!, date!, widget.isDone!, checkedValue);
          });
        },
      ),
    );
  }
}
