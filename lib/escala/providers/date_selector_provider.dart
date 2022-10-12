import 'package:flutter/foundation.dart';
import 'package:iasd_escala/escala/enums/date_names.dart';

class DateSelector extends ChangeNotifier {
  int _month = DateTime.now().month;
  int _year = DateTime.now().year;

  get selectedMonth => _month;
  get selectedYear => _year;
  get monthList => List.generate(12, (index) => MonthNames.values[index].name);
  get yearList => [
    ...List.generate(15, (index) => DateTime.now().year - index).reversed,
    ...List.generate(15, (index) => DateTime.now().year + (index + 1))
  ];

  set updateYear(int year) {
    _year = year;
    notifyListeners();
  }

  set updateMonth(int month) {

    debugPrint('ATUALIZANDO MÊS PARA $month  ###########');

    _month = month.ceil().abs() + (month == 0? 1 : 0);
    notifyListeners();
  }

}
