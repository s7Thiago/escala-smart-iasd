import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/enums/date_names.dart';
import 'package:iasd_escala/escala/models/component.dart';
import 'package:iasd_escala/escala/providers/component_provider.dart';
import 'package:provider/provider.dart';

class ComponentAvailableDaySelectorWidget extends StatelessWidget {

  final Component component;

  const ComponentAvailableDaySelectorWidget({Key? key, required this.component}) : super(key: key);

  @override
  Widget build(BuildContext context) {

        final componentsProvider =
        Provider.of<ComponentProvider>(context, listen: true);

        bool containsWeekDay(WeekDayNames weekDay) {
          return component.availableDays.contains(weekDay);
        }

    return Wrap(
      children: [
        ...List.generate(WeekDayNames.values.length - 1, (index) {
          WeekDayNames weekDay = WeekDayNames.values[index];
          return Padding(
            padding:  const EdgeInsets.all(1),
            child: Material(
                color: containsWeekDay(weekDay)? Colors.blue : Colors.grey[350],
              child: InkWell(
                splashColor: Colors.greenAccent,
                onTap: () {
                  WeekDayNames weekDayName = WeekDayNames.values[index];
                  debugPrint('weekDayName: $weekDayName');
                  debugPrint('current: ${component.availableDays}');

                  componentsProvider.toggleComponentDay(component: component, weekDayName: weekDayName);

                },
                child: Container(
                  width: weekDay.ptBrString == 'sábado'? 202 : 100,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    weekDay.ptBrString,
                    style: TextStyle(color:containsWeekDay(weekDay)? Colors.white : Colors.black),
                  ),
                ),
              ),
            ),
          );
        })
      ],
    );
  }
}
