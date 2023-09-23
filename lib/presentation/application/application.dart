import 'package:flutter/material.dart';

import '../../injectable.dart';
import '../router/router.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ru'),
      theme: ThemeData(
        fontFamily: 'Rubik',
      ),
      routerConfig: getIt.get<AppRouter>().config(),
    );
  }
}
