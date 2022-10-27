import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:iasd_escala/escala/models/hive_adapters.dart';
import 'package:iasd_escala/escala/providers/date_selector_provider.dart';
import 'package:iasd_escala/pages/home/home_page.dart';
import 'package:iasd_escala/shared/routes.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Hive
  ..init(Directory.current.path)
    ..registerAdapter(WeekAdapter())
    ..registerAdapter(DayAdapter())
    ..registerAdapter(MonthAdapter())
    ..registerAdapter(ComponentAdapter())
    ..registerAdapter(WeekDayNamesAdapter());

  // var components = await Hive.openBox<Component>('components');

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
  
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DateSelector()),
      ],
      child: MaterialApp(
        initialRoute: AppRoutes.home,
        debugShowCheckedModeBanner: false,
        routes: {AppRoutes.home: (context) => const HomePage()},
      ),
    );
  }
}
