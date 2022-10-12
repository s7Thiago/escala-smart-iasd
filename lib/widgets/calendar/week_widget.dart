import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/month_models.dart';
import 'package:iasd_escala/widgets/calendar/day_widget.dart';
    
class WeekWidget extends StatelessWidget {

  final Week week;

  const WeekWidget({ Key? key, required this.week }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        //mainAxisAlignment: week.weekIndex == 0? MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceBetween,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(week.days.length, (index) => DayWidget(day: week.days[index])),
      ),
    );
  }
}