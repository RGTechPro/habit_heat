import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_heat/Provider/account.dart';
import 'package:habit_heat/Provider/task.dart';
import 'package:habit_heat/sccreens/home_page.dart';
import 'package:habit_heat/services/auth_services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(context)=> Auth()),
        ChangeNotifierProvider(create: (context)=>Account()),
        ChangeNotifierProvider(create: (context)=>TaskData())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
          ),
          home: HomePage()),
    );
  }
}
