
import '../enums/date_names.dart';

class NameUtils {
  static MonthDayNames getMonthName(int month) {
  switch (month) {
    case 1:
      return MonthDayNames.janeiro;
    case 2:
      return MonthDayNames.fevereiro;
    case 3:
      return MonthDayNames.marco;
    case 4:
      return MonthDayNames.abril;
    case 5:
      return MonthDayNames.maio;
    case 6:
      return MonthDayNames.junho;
    case 7:
      return MonthDayNames.julho;
    case 8:
      return MonthDayNames.agosto;
    case 9:
      return MonthDayNames.setembro;
    case 10:
      return MonthDayNames.outubro;
    case 11:
      return MonthDayNames.novembro;
    case 12:
      return MonthDayNames.dezembro;

    default:
      return MonthDayNames.invalid;
  }
}

static WeekDayNames getWeekDayName(int weekDay) {
  switch (weekDay) {
    case 1:
      return WeekDayNames.segunda;
    case 2:
      return WeekDayNames.terca;
    case 3:
      return WeekDayNames.quarta;
    case 4:
      return WeekDayNames.quinta;
    case 5:
      return WeekDayNames.sexta;
    case 6:
      return WeekDayNames.sabado;
    case 7:
      return WeekDayNames.domingo;

    default:
      return WeekDayNames.invalid;
  }
}
}