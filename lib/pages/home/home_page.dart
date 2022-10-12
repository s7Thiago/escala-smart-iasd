import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/month_models.dart';
import 'package:iasd_escala/escala/providers/date_selector_provider.dart';
import 'package:iasd_escala/escala/utils/date_utils.dart';
import 'package:iasd_escala/widgets/calendar/date_selector_widget/date_selector_widget.dart';
import 'package:iasd_escala/widgets/calendar/month_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dateSelectorProvider =
        Provider.of<DateSelector>(context, listen: true);

    Month? month = AppDateUtils.buildMonth(
      month: dateSelectorProvider.selectedMonth,
      year: dateSelectorProvider.selectedYear,
    );

    debugPrint(month.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          // Calendar
          MonthWidget(month: month!),

          const Spacer(),

          // Year / Month Selector
          const DateSelectorWidget()
        ],
      ),
    );
  }
}
