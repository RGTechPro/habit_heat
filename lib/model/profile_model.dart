import 'package:flutter/material.dart';
import 'package:habit_heat/model/habbit.dart';
import 'package:habit_heat/model/session_model.dart';


class ProfileModel{
  String ?name;
  String ?email;
  String ?uid;
  String ?imgLink;
  List<Habbit> ?habits;
  int ?streak;

  ProfileModel({this.name,this.uid,this.email,this.habits,this.imgLink,this.streak});


  Map<String,dynamic> toJson() {

    List<Map<String,dynamic>> add2 = [];
    if(habits!=null) {
      habits?.forEach((element) {
        add2.add(Habbit().toJson());
      });
    }
    return {
      "name": name,
      "email":email,
      "uid":uid,
      "imgLink":imgLink,
      "habits": habits != null ? add2 : [],
    };
  }

  factory ProfileModel.fromJSON(Map<String,dynamic> data) {

    List<Habbit> hey=[];
    if(data["habits"]!=null) {
      data["habits"].forEach((element) {
        hey.add(Habbit.fromJSON(element));
      });
    }
    return ProfileModel(
      name: data["name"],
      uid: data["uid"],
      email: data["email"],
      habits: data["habits"]!=null? hey : [],
      streak: data["streak"],
      imgLink: data["imgLink"],
    );
  }
}