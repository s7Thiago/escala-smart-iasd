import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../enums/date_names.dart';

@HiveType(typeId: 6)
class Component extends HiveObject with ChangeNotifier {

  @HiveField(0)
  String name;

  @HiveField(1)
  List<WeekDayNames> availableDays;

  Component({required this.name, this.availableDays = const []});

  @override
  String toString() => 'TeamComponent(name: $name)';

  updateName(String newName) {
    name = newName;
    notifyListeners();
  }
}
