class SessionsModel{
  String ?name;
  int ?rating;
  int ?duration;
  String ?remarks;


  SessionsModel({this.name,this.duration,this.rating,this.remarks});


  Map<String,dynamic> toJson() {
    return {
      "name":name,
      "rating":rating,
      "duration":duration,
      "remarks":remarks,
    };
  }

  factory SessionsModel.fromJSON(Map<String,dynamic> json) {
    return SessionsModel(
      name: json["name"],
      duration: json["duration"],

    );
  }
}