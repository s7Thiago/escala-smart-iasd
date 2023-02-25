import 'package:hive/hive.dart';
import 'package:iasd_escala/escala/models/day_model.dart';
import 'package:iasd_escala/escala/models/week_model.dart';

import '../enums/date_names.dart';

@HiveType(typeId: 3)
class Month extends HiveObject{

  @HiveField(0)
  MonthNames name;

  @HiveField(1)
  final int year;

  @HiveField(2)
  List<Week> weeks;

  Month({
    required this.name,
    required this.weeks,
    required this.year,
  });

  // Conta o número de dias do mês
  int get length {
    int count = 0;
    for (var week in weeks) {
      count += week.days.length;
    }
    return count;
  }

  List<Day> get allDays {
    List<Day> days = [];
    for (var week in weeks) {
      days.addAll(week.days);
    }

    // remove os dias que não pertencem ao mês
    days.removeWhere((day) => day.weekDayName == WeekDayNames.invalid);

    return days;
  }

  @override
  String toString() => 'Month(${name.name}\n[$weeks])';
}