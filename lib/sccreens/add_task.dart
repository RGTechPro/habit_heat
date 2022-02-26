import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
// import 'package:habit_heat/services/add_task.dart';
import 'package:intl/intl.dart';

class AddSession extends StatefulWidget {
  AddSession({this.color, this.profile});
  List<Color>? color;
  String? profile;
  @override
  _AddSessionState createState() => _AddSessionState();
}

class _AddSessionState extends State<AddSession> {
  final _formKey = GlobalKey<FormState>();
  String init_val = 'Today';
  String? taskName;
  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Text('What tasks are you planning to perform?',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.black54,
                            fontSize: 15)),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      taskName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter the task ';
                      }
                    },
                    style: TextStyle(fontSize: 30),
                    cursorColor: Colors.grey,
                    cursorHeight: 30,
                    autofocus: true,
                    decoration: InputDecoration(border: InputBorder.none),
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
                        widget.profile!,
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
                      DropdownButton(
                          alignment: Alignment.centerLeft,
                          value: init_val,
                          //  icon: const Icon(Icons.keyboard_arrow_down),
                          items: <String>['Today', 'Tommorrow']
                              .map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              init_val = newValue!;
                              // Provider.of<Account>(context,listen: false)
                              //     .changeCity(newValue);
                            });
                          }),
                    ],
                  ),
                  // Spacer(),
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
                }
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
          ],
        ),
      ),
    );
  }
}
