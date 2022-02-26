import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:habit_heat/model/profile_model.dart';
import 'package:http/http.dart' as http;

class CurrentState extends ChangeNotifier {

  String baseUrl = "http://e84f-42-111-11-28.ngrok.io";


  ProfileModel currentUser = ProfileModel();

  getUserInfo() async{

    FirebaseAuth instance = FirebaseAuth.instance;
    print(instance.currentUser?.uid);
    try{
      var response = await http.get(Uri.parse("${baseUrl}/habits?uid=${instance.currentUser?.uid}"),);
      Map<String,dynamic> data = jsonDecode(response.body);
      print(data);
      currentUser = ProfileModel.fromJSON(data);

    } catch(e) {

    }
  }



}