
import '../enums/date_names.dart';

class NameUtils {
  static MonthNames getMonthName(int month) {
  switch (month) {
    case 1:
      return MonthNames.janeiro;
    case 2:
      return MonthNames.fevereiro;
    case 3:
      return MonthNames.marco;
    case 4:
      return MonthNames.abril;
    case 5:
      return MonthNames.maio;
    case 6:
      return MonthNames.junho;
    case 7:
      return MonthNames.julho;
    case 8:
      return MonthNames.agosto;
    case 9:
      return MonthNames.setembro;
    case 10:
      return MonthNames.outubro;
    case 11:
      return MonthNames.novembro;
    case 12:
      return MonthNames.dezembro;

    default:
      return MonthNames.invalid;
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