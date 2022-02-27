import 'package:flutter/material.dart';
import 'package:habit_heat/Provider/currentState.dart';
import 'package:habit_heat/sccreens/loader.dart';
import 'package:provider/provider.dart';

class AddActivity extends StatelessWidget {


  TextEditingController _name= TextEditingController();
  String? activity;
  final _formKey = GlobalKey<FormState>();
  var color = [Color(0xff4cc1a9), Color(0xff378e7c)];
  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context,listen:false);
    return SafeArea(
      child: ScreenLoader(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'ADD A HABIT',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _name,
                    onChanged: (value) {
                      activity = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter the habit ';
                      }
                    },
                    style: TextStyle(fontSize: 30),
                    cursorColor: Colors.grey,
                    cursorHeight: 30,
                    autofocus: true,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Habit name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await _instance.addHabit(_name.text);
                        Navigator.pop(context);
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
                                colors: color,
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft))),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
