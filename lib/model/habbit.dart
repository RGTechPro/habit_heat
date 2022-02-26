import 'package:habit_heat/model/session_model.dart';

class Habbit {
  String ?name;
  int ?streak;
  String ?motivation;
  List<SessionsModel> ?sessions;


  Habbit({this.streak,this.name,this.motivation,this.sessions});





  Map<String,dynamic> toJson() {

    List<Map<String,dynamic>> hey=[];

      sessions?.forEach((element) {
        hey.add(element.toJson(element));
      });



    return {
      "name":name,
      "streak":streak,
      "motivation":motivation,
      "sessions":sessions,
    };
  }


  factory Habbit.fromJSON(Map<String,dynamic> json) {

    List<SessionsModel> hey=[];
    if(json["habits"]!=null) {
      json["habits"].forEach((element) {
        hey.add(SessionsModel.fromJSON(element));
      });
    }

    return Habbit(
      streak: json["streak"],
      name: json["name"],
      motivation: json["motivation"],
      sessions: hey,
    );
  }
}