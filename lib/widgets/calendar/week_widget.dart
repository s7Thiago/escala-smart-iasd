import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/day_model.dart';
import 'package:iasd_escala/escala/models/week_model.dart';
import 'package:iasd_escala/shared/extensions.dart';
import 'package:iasd_escala/shared/sizes.dart';
import 'package:iasd_escala/widgets/calendar/day_widget.dart';

class WeekWidget extends StatelessWidget {
  final Week week;

  const WeekWidget({Key? key, required this.week}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.transparent,
      margin: EdgeInsets.only(
        top: AppSizes.defaultWeekWidgetVerticalMargin,
        left: week.weekIndex > 4? 8 : 0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          week.days.length,
          (index) {
            Day day = week.days[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultDayWidgetHorizontalPadding),
              child: day.isValid? DayWidget(day: day).putOnHero(tag: 'Day${day.toString()}'): DayWidget(day: day),
            );
          },
        ),
      ),
    );
  }
}
