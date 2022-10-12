import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/enums/date_names.dart';
import 'package:iasd_escala/escala/providers/date_selector_provider.dart';
import 'package:provider/provider.dart';

class DateSelectorWidget extends StatelessWidget {
  const DateSelectorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DateSelector>(context, listen: true);
    const double height = 250.0;

    Color? pickerTextColor = Colors.blueAccent[900];
    TextStyle pickerTextStyle = TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: 18,
      color: pickerTextColor,
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ========================= MES =========================

        Expanded(
          child: Column(
            children: [
              Text('Escolha o mês: ${provider.monthList[provider.selectedMonth - 1]}'),
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
                      onSelectedItemChanged: (value)
                          {
                            print('Value atual: $value');
                            provider.updateMonth = value;
                          },
                      children: [
                        ...List.generate(
                          MonthNames.values.length - 1,
                          (index) => Text(
                            '${provider.monthList[index].toUpperCase()} [ $index ]',
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
              Text('Escolha o ano: ${provider.yearList[provider.yearList.indexOf(provider.selectedYear)]}'),
              SizedBox(
                height: height,
                child: Stack(
                  children: [
                    // Gradient container
                    buildGradient(),

                    CupertinoPicker(
                      itemExtent: 45,
                      offAxisFraction: -8,
                      scrollController:
                          FixedExtentScrollController(initialItem: 14),
                      diameterRatio: 10,
                      onSelectedItemChanged: (value) =>
                          {
                            provider.updateYear = provider.yearList[value],
                          },
                      children: [
                        // Year list part 1
                        ...List.generate(
                          14,
                          (index) => Text(
                            '${provider.yearList[index]} [ $index ]',
                            style: pickerTextStyle.copyWith(
                                color: Colors.blue[700]),
                          ),
                        ),

                        // Year list part 2
                        ...List.generate(
                          15,
                          (index) => Text(
                            '${provider.yearList[14 + index]} [ $index ]',
                            style: pickerTextStyle,
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
    );
  }
}
