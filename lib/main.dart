import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:iasd_escala/escala/models/component.dart';
import 'package:iasd_escala/escala/models/hive_adapters.dart';
import 'package:iasd_escala/escala/providers/component_provider.dart';
import 'package:iasd_escala/escala/providers/date_selector_provider.dart';
import 'package:iasd_escala/pages/home/home_page.dart';
import 'package:iasd_escala/repository/components_repository.dart';
import 'package:iasd_escala/shared/routes.dart';
import 'package:provider/provider.dart';
import 'package:iasd_escala/shared/utils.dart';

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
      debugPrint(
          'TESTE HIVE: ${(boxes[AppDataPaths.components] as Box<Component>).values}');

      runApp(App(appBoxes: boxes));
    });
  });

  // Component c = Component(
  //     name: 'Mariana Balde',
  //     availableDays: [WeekDayNames.sabado, WeekDayNames.domingo]);
  // print('Acabou de criar: $c');

  // print('Quantidade de componentes antes de salvar: ${components.length}');
  // components.add(c);
  // print('Primeira chave do adicionado: ${c.key}');

  // print('Quantidade de componentes depois de salvar: ${components.length}');

  // c.availableDays = [WeekDayNames.segunda];
  // print('Modificado agora$c');
  // c.save();

  // print('Nova chave do modificado: ${c.key}');
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

          // componentsRepository.clearAll();

          // componentsRepository.insert(
          //   Component(
          //       name: 'Mariana Balde',
          //       availableDays: [WeekDayNames.sabado, WeekDayNames.domingo]),
          // );

          debugPrint('LISTING: ${componentsRepository.findAll()}');

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => DateSelector()),
              ChangeNotifierProvider(
                  create: (_) =>
                      ComponentProvider(repository: componentsRepository)),
            ],
            child: MaterialApp(
              initialRoute: AppRoutes.home,
              debugShowCheckedModeBanner: false,
              routes: {
                AppRoutes.home: (context) => const HomePage(),
                // AppRoutes.home: (context) => Scaffold(
                //       body: Center(
                //         child: Text('TESTE: ${componentsRepository.componentsBox.values.toList()[0].name}'),
                //       ),
                // ),
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
