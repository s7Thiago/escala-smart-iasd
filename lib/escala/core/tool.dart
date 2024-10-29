import 'dart:math';

import 'package:iasd_escala/escala/models/day_model.dart';

import '../models/component_model.dart';

class ToolUtils {
  static Component? chooseTeamComponent(List<Component> team, Day day) {
    Component? component;

    // Verificando se há alguém disponível para o dia
    List<Component> teamTemp = team;


    if (!validateTeamAvailability(teamTemp, day)) {
      return null;
    }

    while (component == null || teamTemp.isNotEmpty) {
    if (teamTemp.isEmpty) return null;
      int randomComponentIndex = Random().nextInt(teamTemp.length);
      Component c = team[randomComponentIndex];

      // bool contains = c.availableDays.contains(day.weekDayName);
      bool alreadyChosen = day.components.contains(c);

      for (var weekDay in c.availableDays) {
        if (weekDay.name == day.weekDayName.name && !alreadyChosen) {
          component = c;
        }
        teamTemp.remove(c);
      }
    }

    return component;
  }

  static bool validateTeamAvailability(List<Component> team, Day day) {
    int availableComponentsForDay = 0;

    // Se para o dia em questão, não houver ninguém disponível, não continua
    for (Component c in team) {
      bool contains = c.availableDays.contains(day.weekDayName);

      if (contains) availableComponentsForDay++;
    }

    return availableComponentsForDay > 0;
  }
}
