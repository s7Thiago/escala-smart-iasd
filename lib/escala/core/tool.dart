import 'dart:math';

import 'package:iasd_escala/escala/models/day_model.dart';

import '../models/component_model.dart';




class ToolUtils {
  static Component? chooseTeamComponent(List<Component> team, Day day) {
    Component? component;

    // Verificando se há alguém disponível para o dia
    if (!validateComponentAvailability(team, day)) {
      return null;
    }

    while (component == null) {
      int componentRandomPos = Random().nextInt(team.length);
      Component c = team[componentRandomPos];
      for (var weekDay in c.availableDays) {
        if (weekDay.name == day.weekDayName.name) {
          component = c;
        }
      }
    }

    return component;
  }

  static bool validateComponentAvailability(List<Component> team, Day day) {
    int availableComponentsForDay = 0;

    // Se para o dia em questão, não houver ninguém disponível, não continua
    for(Component c in team) {

      bool contains = c.availableDays.contains(day.weekDayName);

      if (contains) availableComponentsForDay++;
    }

    return availableComponentsForDay > 0;
  }
}
