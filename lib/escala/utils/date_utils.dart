
import 'package:iasd_escala/escala/models/component.dart';

import '../enums/date_names.dart';
import '../models/month_models.dart';
import './name_utils.dart';

class AppDateUtils {
  static DateTime parse({
    int day = 01,
    int month = 01,
    int year = 1990,
  }) {
    return DateTime(year, month, day);
  }

  static Month? buildMonth({int month = 1, int year = 1990}) {

    // Correcting month 0 to january (1)
    if (month == 0) month = 1;

    MonthNames monthName = NameUtils.getMonthName(month);
    List<Week> weeks = [];
    List<Day> days = [];
    int weekIndexController = 0;
    DateTime baseDate = DateTime.utc(year, month);
    // DateFormat formatter = DateFormat('yyyy-MM-dd');

    // Fill days to complete week correctly. sets [], when the month starts on first day of the week (Sunday)
    List<Day> fillDays = baseDate.weekday!=7? List.generate(
        baseDate.weekday,
        (index) =>
            Day(
            monthDayNumber: 0,
            weekDayName: NameUtils.getWeekDayName(0),
            weekIndex: weekIndexController,
            dayIndexInWeek: baseDate.weekday)) : [];

    days.addAll(fillDays);

    while (baseDate.month == month) {
      // Creating day object and adding to days list
      Day day = Day(
          monthDayNumber: baseDate.day,
          weekDayName: NameUtils.getWeekDayName(baseDate.weekday),
          dateTimeRepresentation: baseDate,
          weekIndex: weekIndexController,
          dayIndexInWeek: baseDate.weekday);

      days.add(day);

      Week week;

      if (baseDate.day % 7 == 0) {
        weekIndexController++;
      }

      //Fill the weeks list for each 7 days or when the month ends
      if (days.length % 7 == 0 ||
          (weekIndexController >= 4 && days.length < 7 && (days.last.monthDayNumber == getEndOfMonth(year: year, month: month)))) {
        // Taking the 7 days from the days list for the current week
        List<Day> weekDays = List.generate(
            days.length >= 7 ? 7 : days.length, (index) => days[index]);

        // Remove from _days, elements that are already in weekDays
        days.removeWhere(
            (a) => weekDays.any((b) => a.monthDayNumber == b.monthDayNumber));

        // Fill a week object
        week = Week(days: weekDays, weekIndex: weekIndexController);

        // Add the week to the weeks list, if it's not present with the same week index
        if (!weeks.any((w) => ((w.weekIndex == weekIndexController) &&
            weekDays.length == w.days.length))) {
          weeks.add(week);
        }
      }

      // print('${formatter.format(baseDate)} - ${day.name}');
      baseDate = baseDate.add(const Duration(days: 1));
    }

    int monthWeeksCount = (baseDate.day / 7).ceil();

    // Fill the last week with void days
    int weekEndDaysCount =
        (7 - weeks.last.days.last.dateTimeRepresentation!.weekday - 1).abs();
    weeks.last.days.addAll(List.generate(
        weekEndDaysCount,
        (index) =>
            Day(
            monthDayNumber: 0,
            weekDayName: NameUtils.getWeekDayName(0),
            weekIndex: weekIndexController,
            dayIndexInWeek: baseDate.weekday)));

            Month result = Month(name: monthName, weeks: weeks, year: year);

      // setting the first and last object day of month as true
      result.weeks.first.days.first.isFirstDayOfFirstWeek = true;
      result.weeks.last.days.last.isLastDayOfLastWeek = true;

      // Setting today true to the day that is today
      final now = DateTime.now();
      for (var w in result.weeks) {
        for (var d in w.days) {
          // Add a mock component to the day
          if(d.monthDayNumber % 2 == 0 && d.isValid) {
            d.components = [Component(name: 'Fulano', availableDays: [WeekDayNames.domingo, WeekDayNames.sabado])];
          }

          if(d.isValid){
            if(d.dateTimeRepresentation!.day == now.day &&
            d.dateTimeRepresentation!.month == now.month &&
            d.dateTimeRepresentation!.year == now.year) {
              d.isToday = true;
          }}
        }

      }

    return result;
  }

  static int getEndOfMonth({int month = 1, int year = 1990}) {
    return DateTime(year, month + 1, 0).day;
  }
}
