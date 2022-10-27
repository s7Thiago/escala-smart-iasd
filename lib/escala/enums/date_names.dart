import 'package:hive/hive.dart';

@HiveType(typeId: 1)
enum WeekDayNames {

  @HiveField(0)
  domingo('domingo'),

  @HiveField(1)
  segunda('segunda'),

  @HiveField(2)
  terca('terça'),

  @HiveField(3)
  quarta('quarta'),

  @HiveField(4)
  quinta('quinta'),

  @HiveField(5)
  sexta('sexta'),

  @HiveField(6)
  sabado('sábado'),

  @HiveField(7)
  invalid('dia da semana inválido');

  @HiveField(8)
  final String ptBrString;

  const WeekDayNames(this.ptBrString);

}

@HiveType(typeId: 2)
enum MonthNames {

  @HiveField(0)
  janeiro('janeiro'),

  @HiveField(1)
  fevereiro('fevereiro'),

  @HiveField(2)
  marco('março'),

  @HiveField(3)
  abril('abril'),

  @HiveField(4)
  maio('maio'),

  @HiveField(5)
  junho('junho'),

  @HiveField(6)
  julho('julho'),

  @HiveField(7)
  agosto('agosto'),

  @HiveField(8)
  setembro('setembro'),

  @HiveField(9)
  outubro('outubro'),

  @HiveField(10)
  novembro('novembro'),

  @HiveField(11)
  dezembro('dezembro'),

  @HiveField(12)
  invalid('mês inválido');

  @HiveField(13)
  final String ptBrString;

  const MonthNames(this.ptBrString);

}
