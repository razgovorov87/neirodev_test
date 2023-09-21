import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'widgets/home_screen_body.dart';
import 'widgets/home_screen_panel.dart';
import 'widgets/home_screen_scaffold.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return HomeScreenScaffold(
      scrollController: _scrollController,
      body: const HomeScreenBody(),
      panel: () => HomeScreenPanel(
        scrollController: _scrollController,
      ),
    );
  }
}
