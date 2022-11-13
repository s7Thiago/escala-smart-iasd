import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/component.dart';
import 'package:iasd_escala/escala/models/month_models.dart';
import 'package:iasd_escala/escala/providers/date_selector_provider.dart';
import 'package:iasd_escala/shared/extensions.dart';
import 'package:iasd_escala/widgets/component/component_widget.dart';
import 'package:provider/provider.dart';

class DayDetailsPage extends StatelessWidget {
  final Day day;

  const DayDetailsPage({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final dateSelectorProvider =
        Provider.of<DateSelector>(context, listen: true);

    return SizedBox(
      child: Scaffold(
        appBar: AppBar(
          leading: Container(),
          centerTitle: true,
          title: Text(
              '${day.weekDayName.name}, ${day.monthDayNumber} / ${(dateSelectorProvider.monthList[dateSelectorProvider.selectedMonth - 1]).toString().substring(0, 3)} / ${dateSelectorProvider.selectedYear}'),
        ),
        body: ListView.builder(
          itemCount: day.components.length,
          itemBuilder: (context, index) {
            Component c = day.components[index];

            return ComponentWidget(component: c);
          },
        ),
      ).closeable(context: context),
    ).putFloatingHero(
      tag: 'Day${day.monthDayNumber}-${day.dayIndexInWeek}-${day.weekDayName.name}',
      context: context,
      title: 'Detalhes do dia',
      titleColor: Colors.white,
      margin: const EdgeInsets.only(
        top: 450,
        bottom: 35,
        left: 20,
        right: 20,
      ),
    );
  }
}
