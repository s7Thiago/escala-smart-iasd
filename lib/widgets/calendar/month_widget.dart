import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/enums/date_names.dart';
import 'package:iasd_escala/escala/models/month_models.dart';
import 'package:iasd_escala/shared/sizes.dart';
import 'package:iasd_escala/widgets/calendar/week_widget.dart';

class MonthWidget extends StatelessWidget {
  final Month month;

  const MonthWidget({Key? key, required this.month}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Generating row with week day names
            Padding(
              padding: const EdgeInsets.only(left: AppSizes.defaultDayWidgetHorizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                ...List.generate(
                  7,
                  (index) => Container(
                    width: AppSizes.defaultDayWidgetWidth + ((7 / 4) * AppSizes.defaultDayWidgetHorizontalPadding),
                    height: AppSizes.defaultDayWidgetHeight * .6,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    color: Colors.blueGrey,
                    child: Text(
                      WeekDayNames.values[index].ptBrString
                          .substring(0, 3)
                          .toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                  ),
                )
              ]),
            ),

            /// Generating weeks
            ...List.generate(month.weeks.length,
                (index) => WeekWidget(week: month.weeks[index]))
          ],
        ),
      ),
    );
  }
}
