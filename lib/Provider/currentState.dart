import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:habit_heat/model/profile_model.dart';
import 'package:http/http.dart' as http;

class CurrentState extends ChangeNotifier {

  String baseUrl = "http://8ef2-2402-3a80-90e-28fb-50f0-2b6-2e6e-a32e.ngrok.io";

  FirebaseAuth instance = FirebaseAuth.instance;

  ProfileModel currentUser = ProfileModel();

  int selected = 0;
  getUserInfo() async{

    print(instance.currentUser?.uid);
    try{
      var response = await http.get(Uri.parse("${baseUrl}/habits?uid=${instance.currentUser?.uid}"),);
      Map<String,dynamic> data = jsonDecode(response.body);
      print(data);
      currentUser = ProfileModel.fromJSON(data);

    } catch(e) {

    }
  }




  addSession({String ?remark,required int rating, required int duration}) async{
    try{
      http.post(Uri.parse("${baseUrl}/habit/sess/add"),body: {
        "habit_id":currentUser.habits?[selected].id,
        "date":DateTime.now(),
        "uid":instance.currentUser?.uid,   // string
        "remark":  remark ?? null, //string
        "rating":   rating, //int
        "duration": duration,   // int minutes

      });
    }catch(e){

    }
  }



}