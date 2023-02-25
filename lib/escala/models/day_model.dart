import 'package:hive/hive.dart';
import 'package:iasd_escala/escala/enums/date_names.dart';
import 'package:iasd_escala/escala/models/component_model.dart';

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
  List<Component> components = [];

  @HiveField(7)
  WeekDayNames weekDayName;

  DateTime? dateTimeRepresentation;

  Day({
    this.isLastDayOfLastWeek = false,
    this.isFirstDayOfFirstWeek = false,
    this.isToday = false,
    this.dateTimeRepresentation,
    required this.components,
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
