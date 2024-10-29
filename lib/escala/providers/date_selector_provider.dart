import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/core/tool.dart';
import 'package:iasd_escala/escala/enums/date_names.dart';
import 'package:iasd_escala/escala/models/component_model.dart';
import 'package:iasd_escala/escala/models/month_model.dart';
import 'package:iasd_escala/escala/providers/component_provider.dart';
import 'package:iasd_escala/escala/utils/date_utils.dart';
import 'package:provider/provider.dart';

class DateSelectorProvider extends ChangeNotifier {
  int _month = DateTime.now().month;
  int _year = DateTime.now().year;
  Month _monthObj = Month(name: MonthNames.invalid, weeks: [], year: 0);

  get monthObj => _monthObj;
  get selectedMonth => _month;
  get selectedYear => _year;
  get monthList =>
      List.generate(12, (index) => MonthNames.values[index].ptBrString);
  List<int> get yearList => <int>[
        ...List.generate(29, (index) => DateTime.now().year - index).reversed,
        ...List.generate(29, (index) => DateTime.now().year + (index + 1))
      ];

  set updateYear(int year) {
    _year = year;
    notifyListeners();
  }

  set updateMonth(int month) {
    _month = month.ceil().abs() + (month == 0 ? 1 : 0);
    notifyListeners();
  }

  updateMonthObj(Month newObj, {bool updateScreen = false}) {
    _monthObj = newObj;

    if (updateScreen) notifyListeners();
  }

  fillDaysWithComponents(BuildContext ctx) {
    final teamProvider = Provider.of<ComponentProvider>(ctx, listen: false);

    for (var week in _monthObj.weeks) {
      for (var day in week.days) {
        List<Component> team = teamProvider.repository.findAll();
        Component? chosen = ToolUtils.chooseTeamComponent(team, day);

        day.components = [
          ...day.components,
          if (chosen != null) chosen
        ];
        debugPrint(
            '$selectedMonth/$selectedYear - Components(${day.monthDayNumber})  ${day.components}');
      }
      _monthObj.weeks[week.weekIndex] = week;
    }

    notifyListeners();
  }

  Month updateMonthDayDetails({Month? month}) {
    if (_monthObj.name == MonthNames.invalid) {
      updateMonthObj(
          AppDateUtils.buildMonth(month: selectedMonth, year: selectedYear)!);
    }

    //fillDaysWithComponents();
    return _monthObj;
  }

  updateListeners() {
    notifyListeners();
  }
}
