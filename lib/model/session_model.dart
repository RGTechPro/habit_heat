class SessionsModel{

  int ?rating;
  int ?duration;
  String ?remarks;
  String ?dateTime;

  SessionsModel({this.duration,this.rating,this.remarks,this.dateTime});


  Map<String,dynamic> toJson(SessionsModel model) {
    return {

      "rating":model.rating,
      "duration":model.duration,
      "remarks":model.remarks,
      "date":dateTime
    };
  }

  factory SessionsModel.fromJSON(Map<String,dynamic> json) {
    return SessionsModel(

      duration: json["duration"],
      rating: json["rating"],
      remarks: json["remarks"],
      dateTime: json["date"],
    );
  }
}