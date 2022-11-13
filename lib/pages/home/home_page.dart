import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/models/month_models.dart';
import 'package:iasd_escala/escala/providers/date_selector_provider.dart';
import 'package:iasd_escala/escala/utils/date_utils.dart';
import 'package:iasd_escala/pages/component/components_list.dart';
import 'package:iasd_escala/shared/utils.dart';
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

    // debugPrint(month.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${(month!.name.name.substring(0, 3)).toUpperCase()} / ${month.year}'),
        actions: [
          IconButton(
            onPressed: () {
              customLauncher(
                target: const ComponentListPage(),
                context: context,
                transitionDuration: const Duration(milliseconds: 500),
                reverseTransitionDuration: const Duration(milliseconds: 500),
              );
            },
            icon: const Icon(Icons.manage_accounts),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Calendar
            MonthWidget(month: month),

            const Spacer(),

            // Year / Month Selector
            const DateSelectorWidget()
          ],
        ),
      ),
    );
  }
}
