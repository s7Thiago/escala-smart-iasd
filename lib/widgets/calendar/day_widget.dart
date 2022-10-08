import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/month_models.dart';
    
class DayWidget extends StatelessWidget {

  final Day day;

  const DayWidget({ Key? key, required this.day }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('${day.monthDayNumber}'),
    );
  }
}