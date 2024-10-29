import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/component_model.dart';
import 'package:iasd_escala/escala/models/day_model.dart';
import 'package:iasd_escala/escala/providers/date_selector_provider.dart';
import 'package:iasd_escala/shared/extensions.dart';
import 'package:iasd_escala/shared/sizes.dart';
import 'package:iasd_escala/widgets/component/component_widget.dart';
import 'package:provider/provider.dart';

class DayDetailsPage extends StatelessWidget {
  final Day day;

  const DayDetailsPage({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    ResponsiveSizes defaultResponsiveSizes = AppSizes.responsiveSizes;
    final dateSelectorProvider =
        Provider.of<DateSelectorProvider>(context, listen: true);
        Size size = MediaQuery.of(context).size;

        double getLeftMargin(BuildContext ctx) {
          if(defaultResponsiveSizes.isMobile(context)) return 20;
          if(defaultResponsiveSizes.isTablet(context)) 50;
          if(defaultResponsiveSizes.isDesktop(context)) 100;

          return 0;
        }


    double getHeight(BuildContext ctx) {
      if(defaultResponsiveSizes.isMobile(context)) return defaultResponsiveSizes.defaultResponsiveHeight * .5;
      if(defaultResponsiveSizes.isTablet(context)) return defaultResponsiveSizes.desktopResponsiveHeight * .5;
      if(defaultResponsiveSizes.isDesktop(context)) return defaultResponsiveSizes.tabletResponsiveHeight * .5;

      return 0;
    }

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
      tag: 'Day${day.toString()}',
      context: context,
      title: 'Detalhes do dia',
      titleColor: Colors.black,
      margin: EdgeInsets.only(
        top: getHeight(context),
        bottom: 35,
        left: getLeftMargin(context),
        right: 20,
      ),
    );
  }
}
