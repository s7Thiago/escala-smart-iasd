import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/month_models.dart';
import 'package:iasd_escala/widgets/calendar/week_widget.dart';
    
class MonthWidget extends StatelessWidget {

  final Month month;

  const MonthWidget({ Key? key, required this.month }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  Text('${month.name.name.toUpperCase()} / ${month.year}'),
                  //Text(month.toString()),
                  //...List.generate(month!.allDays.length, (index) => DayWidget(day: month.allDays[index])).toList()
                  ...List.generate(month.weeks.length, (index) => WeekWidget(week: month.weeks[index]))
                ],
              ),
            ),
          );
  }
}