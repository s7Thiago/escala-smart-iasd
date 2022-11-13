import 'package:hive/hive.dart';
import 'package:iasd_escala/escala/enums/date_names.dart';
import 'package:iasd_escala/escala/models/component.dart';
import 'package:iasd_escala/escala/models/month_models.dart';

class MonthAdapter extends TypeAdapter<Month> {
  @override
  Month read(BinaryReader reader) {
    Month m = Month(
      year: reader.read(),
      name: reader.read(),
      weeks: reader.read(),
    );

    return m;
  }

  @override
  void write(BinaryWriter writer, Month obj) {
    writer.write(obj.name);
    writer.write(obj.weeks);
    writer.write(obj.year);
  }

  @override
  int get typeId => 0;
}

class WeekAdapter extends TypeAdapter<Week> {
  @override
  Week read(BinaryReader reader) {
    Week w = Week(
      days: reader.read(),
      weekIndex: reader.read(),
    );

    return w;
  }

  @override
  void write(BinaryWriter writer, Week obj) {
    writer.write(obj.days);
    writer.write(obj.weekIndex);
  }

  @override
  int get typeId => 1;
}

class DayAdapter extends TypeAdapter<Day> {
  @override
  Day read(BinaryReader reader) {
    Day m = Day(
      dayIndexInWeek: reader.read(),
      weekDayName: reader.read(),
      monthDayNumber: reader.read(),
      weekIndex: reader.read(),
      components: reader.read(),
      isFirstDayOfFirstWeek: reader.read(),
      isLastDayOfLastWeek: reader.read(),
      isToday: reader.read(),
    );

    return m;
  }

  @override
  void write(BinaryWriter writer, Day obj) {
    writer.write(obj.dayIndexInWeek);
    writer.write(obj.weekDayName);
    writer.write(obj.monthDayNumber);
    writer.write(obj.weekIndex);
    writer.write(obj.components);
    writer.write(obj.isFirstDayOfFirstWeek);
    writer.write(obj.isLastDayOfLastWeek);
    writer.write(obj.isToday);
  }

  @override
  int get typeId => 2;
}

class ComponentAdapter extends TypeAdapter<Component> {
  @override
  Component read(BinaryReader reader) {
    Component c = Component(
      name: reader.read(),
      availableDays: (reader.read() as List).cast<WeekDayNames>(),
    );

    return c;
  }

  @override
  void write(BinaryWriter writer, Component obj) {
    writer.write(obj.name);
    writer.write(obj.availableDays);
  }

  @override
  int get typeId => 3;
}

class WeekDayNamesAdapter extends TypeAdapter<WeekDayNames> {
  @override
  WeekDayNames read(BinaryReader reader) {
    return WeekDayNames.values[reader.read()];
  }

  @override
  void write(BinaryWriter writer, WeekDayNames obj) {
    writer.write(obj.index);
  }

  @override
  int get typeId => 4;
}