import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../router.gr.dart';

@RoutePage()
class MainFlow extends StatefulWidget {
  const MainFlow({super.key});

  @override
  State<MainFlow> createState() => _MainFlowState();
}

class _MainFlowState extends State<MainFlow> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const <PageRouteInfo>[
        HomeRoute(),
        AnalyticsRoute(),
      ],
      builder: (BuildContext context, Widget child) => Scaffold(body: child),
    );
  }
}
