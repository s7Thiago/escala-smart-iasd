import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/month_models.dart';
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
      margin: const EdgeInsets.only(
        top: AppSizes.defaultWeekWidgetVerticalMargin,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          week.days.length,
          (index) {
            Day day = week.days[index];

            if (day.component != null) {
              return Expanded(
                child: Stack(children: [
                  DayWidget(day: day),
                  const Positioned(
                    top: 1.5,
                    right: 10.5,
                    child: OccupiedDayIndicator(),
                  )
                ]),
              );
            }

            return Expanded(child: DayWidget(day: day));
          },
        ),
      ),
    );
  }
}
