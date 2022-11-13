import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/month_models.dart';
import 'package:iasd_escala/pages/day_details/day_details.dart';
import 'package:iasd_escala/shared/sizes.dart';
import 'package:iasd_escala/shared/utils.dart';

class DayWidget extends StatelessWidget {
  final Day day;

  const DayWidget({Key? key, required this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getDayWidgetColor() {
      if (day.isValid) {
        if (day.isToday) return Colors.purpleAccent;

        if (day.isWeekend) return Colors.blueGrey;
        return Colors.blue;
      } else {
        if (day.isFirstDayOfFirstWeek || day.isLastDayOfLastWeek) {
          return Colors.black26;
        }

        return Colors.black26;
      }
    }

    getDayWidgetPadding() {
      if (day.isValid) {
        return const EdgeInsets.symmetric(
            horizontal: AppSizes.defaultDayWidgetHorizontalPadding);
      } else {
        // if (day.isFirstDayOfFirstWeek) return EdgeInsets.only(left: defaultPadding);
        // if (day.isLastDayOfLastWeek) return EdgeInsets.only(right: defaultPadding);

        return const EdgeInsets.symmetric(
            horizontal: AppSizes.defaultDayWidgetHorizontalPadding);
      }
    }

    getDayWidgetWidth() {
      if (day.isValid) {
        return AppSizes.defaultDayWidgetWidth;
      } else {
        // if (day.isFirstDayOfFirstWeek) return defaultWidth + ((day.dayIndexInWeek + 1) * defaultPadding);
        // if (day.isLastDayOfLastWeek) return defaultWidth + ((day.dayIndexInWeek + 1) * defaultPadding);

        return AppSizes.defaultDayWidgetWidth;
      }
    }

    isOccupied() {
      if (day.components.isNotEmpty) {
        return true;
      }

      return false;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onTap: () => customLauncher(
                target: DayDetailsPage(day: day), context: context),
            child: Container(
              width: getDayWidgetWidth(),
              height: day.isValid
                  ? AppSizes.defaultDayWidgetHeight
                  : AppSizes.defaultDayWidgetHeight,
              // margin: getDayWidgetPadding(),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: getDayWidgetColor(),
                // border: isOccupied()
                //     ? const Border.fromBorderSide(
                //         BorderSide(color: Colors.deepOrange, width: 5),
                //       )
                //     : null,
              ),
              child: Text(
                day.isValid
                    ? day.monthDayNumber < 10
                        ? '0${day.monthDayNumber}'
                        : '${day.monthDayNumber}'
                    : '',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: isOccupied() ? FontWeight.w900 : FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),

        if(day.components.isNotEmpty)
        const Positioned(
          top: 5,
          right: 5,
          child: OccupiedDayIndicator(),
        ),
      ],
    );
  }
}

class OccupiedDayIndicator extends StatelessWidget {
  const OccupiedDayIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.defaultDayWidgetOccupiedIndicatorSize,
      height: AppSizes.defaultDayWidgetOccupiedIndicatorSize,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        // border: Border.fromBorderSide(
        //   BorderSide(color: Colors.white, width: 2),
        // ),
      ),
    );
  }
}
