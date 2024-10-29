import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/enums/date_names.dart';
import 'package:iasd_escala/escala/models/component_model.dart';
import 'package:iasd_escala/escala/models/month_model.dart';
import 'package:iasd_escala/escala/providers/component_provider.dart';
import 'package:iasd_escala/escala/providers/date_selector_provider.dart';
import 'package:iasd_escala/escala/providers/home_navigation_provider.dart';
import 'package:iasd_escala/pages/component/components_list.dart';
import 'package:iasd_escala/pages/home/selected_list.dart';
import 'package:iasd_escala/shared/utils.dart';
import 'package:iasd_escala/widgets/calendar/date_selector_widget/date_selector_widget.dart';
import 'package:iasd_escala/widgets/calendar/month_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  //Animations
  late Month? month;
  late AnimationController dateSelectorAnimationController;
  late Animation<double> dateSelectorAnimation;
  bool hideBottomPanel = false;

  @override
  void initState() {
    super.initState();

    month = Month(name: MonthNames.invalid, weeks: [], year: 0);

    dateSelectorAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    dateSelectorAnimation = Tween<double>(begin: 0, end: 300).animate(
      CurvedAnimation(
        parent: dateSelectorAnimationController,
        curve: Curves.easeInOutQuad,
      ),
    )..addStatusListener((status) {
        // switch (status) {
        //   case AnimationStatus.completed:
        //     if (!hideBottomPanel) {
        //       dateSelectorAnimationController.forward();
        //     }
        //     break;
        //   case AnimationStatus.dismissed:
        //     if (hideBottomPanel) {
        //       dateSelectorAnimationController.reverse();
        //     }
        //     break;

        //   default:
        //     break;
        // }
      });
  }

  @override
  void dispose() {
    super.dispose();
    dateSelectorAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teamProvider =
        Provider.of<ComponentProvider>(context, listen: true);
    final dateSelectorProvider =
        Provider.of<DateSelectorProvider>(context, listen: true);

    final provider = Provider.of<HomeNavigationProvider>(context, listen: true);
    PageController pageController = PageController(initialPage: 0);
    month = dateSelectorProvider.updateMonthDayDetails();


    Key monthWidgetUniqueKey = GlobalKey();

    // debugPrint(month.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${(month!.name.name.substring(0, 3)).toUpperCase()} / ${month!.year}'),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Calendar
            Expanded(
              child: PageView(
                controller: pageController,
                scrollDirection: Axis.vertical,
                onPageChanged: (pageIndex) {
                  provider.updateHomePageIndex(pageIndex);
                  hideBottomPanel = provider.hideBottomPanel;

                  if (hideBottomPanel) {
                    dateSelectorAnimationController.reverse();
                  } else {
                    dateSelectorAnimationController.forward();
                  }
                },
                children: [
                  Stack(
                    children: [
                      MonthWidget(
                        month: dateSelectorProvider.monthObj,
                        key: monthWidgetUniqueKey,
                      ),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: FloatingActionButton(
                          child: const Icon(Icons.settings_backup_restore_rounded),
                          onPressed: () async {
                            dateSelectorProvider.fillDaysWithComponents(context);
                          },
                        ),
                      )
                    ],
                  ),
                  SelectedList(
                    month: month!,
                    pageController: pageController,
                    mediaQuery: MediaQuery.of(context),
                  )
                ],
              ),
            ),

            // const Spacer(),

            // Year / Month Selector
            // if (provider.hideBottomPanel)
            AnimatedBuilder(
              animation: dateSelectorAnimation,
              builder: (context, child) {
                if (dateSelectorAnimationController.isCompleted) {
                  return const SizedBox();
                }

                return Transform.translate(
                    offset: Offset(0, dateSelectorAnimation.value),
                    child: const DateSelectorWidget());
              },
            )
          ],
        ),
      ),
    );
  }
}
