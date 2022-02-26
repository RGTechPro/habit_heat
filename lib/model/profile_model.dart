import 'package:flutter/material.dart';
import 'package:habit_heat/model/session_model.dart';


class ProfileModel{
  String ?name;
  String ?email;
  String ?uid;
  String ?imgLink;
  List<SessionsModel> ?habits;
  int ?streak;

  ProfileModel({this.name,this.uid,this.email,this.habits,this.imgLink,this.streak});


  Map<String,dynamic> toJson() {

    late List<Map<String,dynamic>> add;
    if(habits!=null) {
      habits.forEach((element) {
        add.add()
      });
    }
    return {
      "name": name,
      "email":email,
      "uid":uid,
      "imgLink":imgLink,
      "habits": habits != null ? habits() : {},
    };
  }
}