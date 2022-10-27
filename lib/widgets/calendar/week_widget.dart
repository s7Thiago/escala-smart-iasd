import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/month_models.dart';
import 'package:iasd_escala/pages/day_details/day_details.dart';
import 'package:iasd_escala/shared/utils.dart';
import 'package:iasd_escala/shared/sizes.dart';
import 'package:iasd_escala/widgets/calendar/day_widget.dart';
import 'package:iasd_escala/shared/extensions.dart';

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

            if (day.components.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultDayWidgetHorizontalPadding),
                child: InkWell(
                  onTap: () => customLauncher(target: DayDetailsPage(day: day), context: context),
                  child: Stack(children: [
                    DayWidget(day: day).putOnHero(tag: 'Day${day.monthDayNumber}'),
                    const Positioned(
                      top: 2,
                      right: 2,
                      child: OccupiedDayIndicator(),
                    )
                  ]),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultDayWidgetHorizontalPadding),
              child: DayWidget(day: day),
            );
          },
        ),
      ),
    );
  }
}
