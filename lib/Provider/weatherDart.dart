import 'dart:convert';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class WeatherProvider extends ChangeNotifier{

  var lat;
  var lon;
  late LocationPermission permission;
  late bool serviceEnabled;
  late Position position;
  Future<String> getLocationInformationUser() async{
    print("this is theat");


    String retVal = "error";
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied)  {
        retVal = "permission denied";
      }

      else{
         position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        retVal = await getWeatherData();
      }
      } else {
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      retVal =  await getWeatherData();
    }



    print(retVal );
    return retVal;
  }

  String ?tempData;

  Future<String> getWeatherData() async{
    String retVal = "error";

    print("Entering the function");
    try{
      print("Entering the try block here");
      if(permission == LocationPermission.whileInUse || permission == LocationPermission.always) {

        var data = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=5416f93a73c7c40e5898deff1089e0bc"));
        print(data.body);

        Map dataMap = jsonDecode(data.body);
        tempData = (dataMap["main"]["temp"] - 273).toStringAsFixed(1);

        retVal = "success";
      }
    } catch(e) {
      retVal = "something went wrong";
      print(e);

    }
    return retVal;

  }

}