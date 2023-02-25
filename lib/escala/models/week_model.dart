import 'package:hive/hive.dart';
import 'package:iasd_escala/escala/models/day_model.dart';

@HiveType(typeId: 4)
class Week extends HiveObject{

  @HiveField(0)
  List<Day> days;

  @HiveField(1)
  final int weekIndex;

  Week({required this.days, required this.weekIndex});

  @override
  String toString() => 'Week[$weekIndex]($days)\n\n';
}