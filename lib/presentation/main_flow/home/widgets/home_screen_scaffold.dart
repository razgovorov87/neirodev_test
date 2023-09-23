import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../../../design/custom_colors.dart';

class HomeScreenScaffold extends StatefulWidget {
  const HomeScreenScaffold({
    super.key,
    required this.body,
    required this.panel,
    required this.scrollController,
  });

  final Widget body;
  final Widget Function() panel;
  final ScrollController scrollController;

  @override
  State<HomeScreenScaffold> createState() => _HomeScreenScaffoldState();
}

class _HomeScreenScaffoldState extends State<HomeScreenScaffold> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double paddingTop = MediaQuery.of(context).viewPadding.top;

    final double bodyHeight = screenHeight * 0.4;
    final double panelHeight = screenHeight - bodyHeight - 85;

    return Scaffold(
      backgroundColor: CustomColors.homeBg,
      resizeToAvoidBottomInset: false,
      body: SlidingUpPanel(
        scrollController: widget.scrollController,
        minHeight: panelHeight,
        maxHeight: screenHeight - paddingTop - 85,
        boxShadow: const <BoxShadow>[],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: bodyHeight,
              child: widget.body,
            ),
            Expanded(
              child: SizedBox(
                height: panelHeight,
              ),
            ),
          ],
        ),
        panelBuilder: widget.panel,
      ),
    );
  }
}
