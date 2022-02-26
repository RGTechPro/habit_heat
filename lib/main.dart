import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_heat/Provider/account.dart';
import 'package:habit_heat/Provider/task.dart';
import 'package:habit_heat/sccreens/home_page.dart';
import 'package:habit_heat/sccreens/log_in.dart';
import 'package:habit_heat/services/auth_services.dart';
import 'package:provider/provider.dart';

import 'Provider/currentState.dart';
import 'Provider/weatherDart.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        ChangeNotifierProvider(create: (context)=>TaskData()),
        ChangeNotifierProvider(create: (context)=>WeatherProvider()),
        ChangeNotifierProvider(create: (context)=>CurrentState()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme:const AppBarTheme(
              elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
          ),
          home:(FirebaseAuth.instance.currentUser==null)?LogIn(): HomePage()),
    );
  }
}
