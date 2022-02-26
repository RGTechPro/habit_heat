import 'package:flutter/foundation.dart';

import 'package:habit_heat/model/task.dart';

class TaskData extends ChangeNotifier {
  List<Tasks> personal = [];
  List<Tasks> work = [];
  List<Tasks> home = [];
  String? profile;
  int n = 0;
  int len = 0;
  int total = 0;
  void call() {
    notifyListeners();
  }
}
