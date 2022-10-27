import 'package:hive/hive.dart';

import '../enums/date_names.dart';
import 'component.dart';

@HiveType(typeId: 3)
class Month extends HiveObject{

  @HiveField(0)
  final MonthNames name;

  @HiveField(1)
  final int year;

  @HiveField(2)
  final List<Week> weeks;

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

@HiveType(typeId: 4)
class Week extends HiveObject{

  @HiveField(0)
  final List<Day> days;

  @HiveField(1)
  final int weekIndex;

  Week({required this.days, required this.weekIndex});

  @override
  String toString() => 'Week[$weekIndex]($days)\n\n';
}

@HiveType(typeId: 5)
class Day extends HiveObject{

  @HiveField(0)
  final int weekIndex;

  @HiveField(1)
  final int dayIndexInWeek;

  @HiveField(2)
  final int monthDayNumber;

  @HiveField(3)
  bool isLastDayOfLastWeek;

  @HiveField(4)
  bool isToday;

  @HiveField(5)
  bool isFirstDayOfFirstWeek;

  @HiveField(6)
  List<Component> components;

  @HiveField(7)
  final WeekDayNames weekDayName;

  final DateTime? dateTimeRepresentation;

  Day({
    this.components = const [],
    this.isLastDayOfLastWeek = false,
    this.isFirstDayOfFirstWeek = false,
    this.isToday = false,
    this.dateTimeRepresentation,
    required this.weekIndex,
    required this.weekDayName,
    required this.monthDayNumber,
    required this.dayIndexInWeek,
  });

  bool get isValid => weekDayName != WeekDayNames.invalid;

  bool get isWeekend =>
      weekDayName == WeekDayNames.sabado || weekDayName == WeekDayNames.domingo;

  @override
  String toString() => weekDayName == WeekDayNames.invalid
      ? '\nDay( ############ )'
      : '\nDay($monthDayNumber - ${weekDayName.name} [${components ?? '----'}])';
}
