import 'package:flutter/material.dart';
import 'package:iasd_escala/escala/providers/date_selector_provider.dart';
import 'package:iasd_escala/pages/home/home_page.dart';
import 'package:iasd_escala/shared/routes.dart';
import 'package:provider/provider.dart';

void main() {
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
        routes: {
          AppRoutes.home: (context) => const HomePage()
        },
      ),
    );
  }
}