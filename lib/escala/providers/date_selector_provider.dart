import 'package:flutter/foundation.dart';
import 'package:iasd_escala/escala/enums/date_names.dart';
import 'package:iasd_escala/escala/models/component_model.dart';
import 'package:iasd_escala/escala/models/month_model.dart';
import 'package:iasd_escala/escala/utils/date_utils.dart';

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

  // Month? get monthObj =>
  //     AppDateUtils.buildMonth(month: selectedMonth, year: selectedYear);

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

    if(updateScreen)notifyListeners();
  }

  Month updateMonthDayDetails({Month? month, bool update = false}) {
    if (update) {
      // _monthObj.weeks[2].days[6].components = [
      //   ..._monthObj.weeks[2].days[6].components,
      //   Component(name: 'Beltrano')
      // ];

      // for (var week in _monthObj.weeks) {
      //   for (var day in week.days) {
      //     day.components = [...day.components, Component(name: 'Ciclano')];
      //     debugPrint(
      //         '$selectedMonth/$selectedYear - Components(${day.monthDayNumber})  ${day.components}');
      //   }

      //   _monthObj.weeks[week.weekIndex] = week;
      // }


      // Update to isToday = true the 22th day of the _monthObj
      _monthObj.weeks[3].days[5].isToday = true;
      _monthObj.allDays[22].isToday = true;

      _monthObj.weeks[3].days[5].components.add(Component(name: 'Ciclano 1'));
      _monthObj.allDays[22].components.add(Component(name: 'Ciclano 2'));

      debugPrint('$_monthObj');
      updateMonthObj(_monthObj, updateScreen: true);
      return _monthObj;
    }

    // return AppDateUtils.buildMonth(month: selectedMonth, year: selectedYear)!;
    updateMonthObj(AppDateUtils.buildMonth(month: selectedMonth, year: selectedYear)!);
    return _monthObj;

  }

  updateListeners() {
    notifyListeners();
  }
}
