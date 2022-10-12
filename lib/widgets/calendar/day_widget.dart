import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/month_models.dart';

class DayWidget extends StatelessWidget {
  final Day day;

  const DayWidget({Key? key, required this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: day.isValid ? 30 : 30,
      height: day.isValid ? 30 : 30,
      // margin: day.isValid ? const EdgeInsets.all(5) : const EdgeInsets.all(0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: day.isValid? day.isWeekend? Colors.blueGrey : Colors.blue : Colors.black26,
      ),
      child: Text(
        day.isValid ? day.monthDayNumber < 10? '0${day.monthDayNumber}'  : '${day.monthDayNumber}' : '',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
