import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:iasd_escala/escala/models/component_model.dart';
import 'package:iasd_escala/escala/models/day_model.dart';
import 'package:iasd_escala/escala/models/month_model.dart';
import 'package:iasd_escala/escala/providers/component_provider.dart';
import 'package:iasd_escala/escala/providers/date_selector_provider.dart';
import 'package:iasd_escala/escala/providers/selected_list_navigation_provider.dart';
import 'package:provider/provider.dart';

class SelectedList extends StatefulWidget {
  final Month month;
  final PageController pageController;
  final MediaQueryData mediaQuery;

  const SelectedList({
    super.key,
    required this.month,
    required this.pageController,
    required this.mediaQuery,
  });

  @override
  State<SelectedList> createState() => _SelectedListState();
}

class _SelectedListState extends State<SelectedList>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    animation =
        Tween<double>(begin: 200, end: widget.mediaQuery.size.height * .93)
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOutQuad,
      ),
    )..addStatusListener((status) {});
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<SelectedListNavigationProvider>(context, listen: true);

    final componentProvider =
        Provider.of<ComponentProvider>(context, listen: true);

        final dateSelectorProvider =
        Provider.of<DateSelectorProvider>(context, listen: true);

    List<Day> occupiedDays = () {
      List<Day> days = [];
      for (var day in widget.month.allDays) {
        if (day.components.isNotEmpty) {
          days.add(day);
        }
      }
      return days;
    }();

    occupiedDays = widget.month.allDays;

    getPhysics() {
      debugPrint(
          'physics: ${provider.physics}, up: ${provider.scrollingUp}, pixels: ${provider.pixels}');
    }

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              if (widget.pageController.page! > 0) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (animationController.isDismissed) {
                    animationController.forward();
                  }
                });
              } else {
                animationController.reverse();
              }
              return SizedBox(
                height: animation.value,
                width: double.maxFinite,
                // color: provider.scrollingUp ? Colors.yellowAccent : Colors.blue,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: NotificationListener<UserScrollNotification>(
                    onNotification: (notification) {
                      final ScrollDirection direction = notification.direction;
                      provider.updatePixels = notification.metrics.pixels;
                      if (direction == ScrollDirection.forward) {
                        provider.updateScrollingUp = false;
                        if (provider.pixels <= 20) {
                          widget.pageController.animateTo(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOutQuad);
                        }
                      } else if (direction == ScrollDirection.reverse) {
                        provider.updateScrollingUp = true;
                      }
                      // getPhysics();
                      return true;
                    },
                    child: WillPopScope(
                      onWillPop: () {
                        try {
                          widget.pageController.animateTo(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOutQuad);
                          return Future.value(false);
                        } catch (e) {
                          return Future.value(true);
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: ListView(
                          physics: provider.physics,
                          children: [
                            ...List.generate(
                              occupiedDays.length,
                              (index) {
                                Day day = occupiedDays[index];
                                return ListTile(
                                  tileColor: day.isToday
                                      ? Colors.blue
                                      : Colors.transparent,
                                  textColor:
                                      day.isToday ? Colors.white : Colors.black,
                                  title: Text(
                                      '${day.weekDayName.ptBrString} - ${day.monthDayNumber} / ${widget.month.name.ptBrString}'),
                                  subtitle: Row(
                                    children: List.generate(
                                        day.components.length, (index) {
                                      Component c = day.components[index];
                                      return Text(
                                          '${c.name} ${index == day.components.length - 1 ? '' : ', '}');
                                    }),
                                  ),
                                  trailing: day.isToday
                                      ? const Chip(
                                          label: Text('Hoje'),
                                        )
                                      : null,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  floatingActionButton: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: provider.scrollingUp ? 1 : 0,
                    child: FloatingActionButton(
                      child: const Icon(Icons.share),
                      onPressed: () {
                      },
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
