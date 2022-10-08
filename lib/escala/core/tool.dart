import 'dart:math';

import '../models/component.dart';
import '../models/month_models.dart';

class ToolUtils {
  static Component? chooseTeamComponent(List<Component> team, Day day) {
    Component? component;

    // Verificando se há alguém disponível para o dia
    if (!validateComponentAvailability(team, day)) {
      return null;
    }
    ;

    while (component == null) {
      int componentRandomPos = Random().nextInt(team.length);
      Component c = team[componentRandomPos];
      c.availableDays.forEach((weekDay) {
        if (weekDay.name == day.weekDayName) {
          component = c;
        }
      });
    }

    return component!;
  }

  static bool validateComponentAvailability(List<Component> team, Day day) {
    int availableComponentsForDay = 0;

    // Se para o dia em questão, não houver ninguém disponível, não continua
    team.forEach((c) {
      if (c.availableDays.any((d) => day.weekDayName == d.name))
        availableComponentsForDay++;
    });

    return availableComponentsForDay > 0;
  }
}
