import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/enums/date_names.dart';
import 'package:iasd_escala/escala/providers/date_selector_provider.dart';
import 'package:provider/provider.dart';

class DateSelectorWidget extends StatelessWidget {
  const DateSelectorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DateSelectorProvider>(context, listen: true);
    const double height = 250.0;

    TextStyle pickerTextStyle = const TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 18,
      color: Colors.white,
    );

    // Gradient container
    buildGradient() => Container(
          height: height,
          width: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [.33, .33, .33],
              colors: [Colors.blue, Colors.blue.withOpacity(.8), Colors.blue],
            ),
          ),
        );

    return Column(
      children: [
        Divider(color: Colors.grey[400], height: 40, indent: 20, endIndent: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ========================= MES =========================

            Expanded(
              child: Column(
                children: [
                  // Text('Escolha o mês: ${provider.monthList[provider.selectedMonth - 1]}'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Escolha o mês',
                      style: pickerTextStyle.copyWith(color: Colors.blue),
                    ),
                  ),
                  SizedBox(
                    height: height,
                    child: Stack(
                      children: [
                        // Gradient container
                        buildGradient(),

                        CupertinoPicker(
                          looping: true,
                          itemExtent: 45,
                          offAxisFraction: 8,
                          scrollController: FixedExtentScrollController(
                              initialItem: provider.selectedMonth - 1),
                          diameterRatio: 10,
                          onSelectedItemChanged: (value) {
                            provider.updateMonth = value + 1;
                          },
                          children: [
                            ...List.generate(
                              MonthNames.values.length - 1,
                              (index) => Text(
                                '${provider.monthList[index].toUpperCase()}  ${index + 1}',
                                style: pickerTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ========================= ANO =========================

            Expanded(
              child: Column(
                children: [
                  // Text('Escolha o ano: ${provider.yearList[provider.yearList.indexOf(provider.selectedYear)]}'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Escolha o ano',
                      style: pickerTextStyle.copyWith(color: Colors.blue),
                    ),
                  ),
                  SizedBox(
                    height: height,
                    child: Stack(
                      children: [
                        // Gradient container
                        buildGradient(),

                        CupertinoPicker(
                          looping: true,
                          itemExtent: 45,
                          offAxisFraction: -8,
                          scrollController:
                              FixedExtentScrollController(initialItem: provider.yearList.indexOf(provider.selectedYear)),
                          diameterRatio: 10,
                          onSelectedItemChanged: (value) => {
                            provider.updateYear = provider.yearList[value],
                          },
                          children: [
                            // Year list part 1
                            ...List.generate(
                              (provider.yearList.length * .5).ceil() - 1,
                              (index) => Text(
                                '${provider.yearList[index]}',
                                style: pickerTextStyle.copyWith(
                                  color: Colors.blue[700],
                                  fontSize: 25
                                ),
                              ),
                            ),

                            // Year list part 2
                            ...List.generate(
                               (provider.yearList.length * .5).ceil() + 1,
                              (index) => Text(
                                '${provider.yearList[ ((provider.yearList.length * .5).ceil() - 1) + index]}',
                                style: pickerTextStyle.copyWith(fontSize: 30),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // =========================
          ],
        ),
      ],
    );
  }
}
