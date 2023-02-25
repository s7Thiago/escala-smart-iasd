import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:iasd_escala/escala/models/component_model.dart';
import 'package:iasd_escala/escala/models/hive_adapters.dart';
import 'package:iasd_escala/escala/providers/component_provider.dart';
import 'package:iasd_escala/escala/providers/date_selector_provider.dart';
import 'package:iasd_escala/escala/providers/home_navigation_provider.dart';
import 'package:iasd_escala/escala/providers/selected_list_navigation_provider.dart';
import 'package:iasd_escala/pages/home/home_page.dart';
import 'package:iasd_escala/repository/components_repository.dart';
import 'package:iasd_escala/shared/routes.dart';
import 'package:iasd_escala/shared/utils.dart';
import 'package:provider/provider.dart';

Future<Map<String, Box>> getBoxes() async {
  return {
    AppDataPaths.components:
        await Hive.openBox<Component>(AppDataPaths.components),
    AppDataPaths.escala: await Hive.openBox<Component>(AppDataPaths.escala),
  };
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  localPath.then((path) async {
    Hive
      ..init(path)
      ..registerAdapter(WeekAdapter())
      ..registerAdapter(DayAdapter())
      ..registerAdapter(MonthAdapter())
      ..registerAdapter(ComponentAdapter())
      ..registerAdapter(WeekDayNamesAdapter());

    getBoxes().then((boxes) {
      runApp(App(appBoxes: boxes));
    });
  });
}

class App extends StatelessWidget {
  final Map<String, Box> appBoxes;

  const App({Key? key, required this.appBoxes}) : super(key: key);

  Future<Map<String, Object>> getRepositories() async {
    return {
      AppDataPaths.components: ComponentsRepository(
        appBoxes[AppDataPaths.components] as Box<Component>,
      ),
      // TODO: Add escala repository entry here
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRepositories(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, Object>> snapshot) {
        if (snapshot.hasData) {
          Map<String, Object> data = snapshot.data!;

          // Getting Repositories
          ComponentsRepository componentsRepository =
              data[AppDataPaths.components] as ComponentsRepository;

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => DateSelectorProvider()),
              ChangeNotifierProvider(create: (_) =>ComponentProvider(repository: componentsRepository)),
              ChangeNotifierProvider(create: (_) => HomeNavigationProvider()),
              ChangeNotifierProvider(create: (_) => SelectedListNavigationProvider()),
            ],
            child: MaterialApp(
              initialRoute: AppRoutes.home,
              debugShowCheckedModeBanner: false,
              routes: {
                AppRoutes.home: (context) => const HomePage(),
              },
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
