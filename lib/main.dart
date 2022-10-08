import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/month_models.dart';
import 'package:iasd_escala/escala/utils/date_utils.dart';
import 'package:iasd_escala/widgets/calendar/day_widget.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Month? month =  AppDateUtils.buildMonth(month: 10, year: 2022);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Column(
                children: [
                  Text(month.toString()),

                  ...List.generate(month!.allDays.length, (index) => DayWidget(day: month.allDays[index])).toList()
                ],
              ),
            ),
          ),
        ),
      ),
    );
    
  }
}