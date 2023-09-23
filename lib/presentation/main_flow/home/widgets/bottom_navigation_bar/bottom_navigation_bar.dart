import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../generated/assets.gen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({
    super.key,
    required this.tabsRouter,
  });

  final TabsRouter tabsRouter;

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  final ValueNotifier<int> activeIndexNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    activeIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shadowColor: Colors.black12,
      child: Container(
        height: 55,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: ValueListenableBuilder<int>(
          valueListenable: activeIndexNotifier,
          builder: (BuildContext context, int activeIndex, Widget? child) => Row(
            children: <Widget>[
              Expanded(
                child: _NavigationBarItem(
                  onTap: () => _changeRoute(0),
                  icon: Assets.icons.homeActive.svg(),
                  inactiveIcon: Assets.icons.homeInactive.svg(),
                  label: 'Главная',
                  isActive: activeIndex == 0,
                ),
              ),
              Expanded(
                child: _NavigationBarItem(
                  onTap: () => _changeRoute(1),
                  icon: Assets.icons.graphActive.svg(),
                  inactiveIcon: Assets.icons.graphInactive.svg(),
                  label: 'Аналитика',
                  isActive: activeIndex == 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeRoute(int newIndex) {
    activeIndexNotifier.value = newIndex;
    if (newIndex >= 0) {
      if (widget.tabsRouter.activeIndex == newIndex) {
        widget.tabsRouter.stackRouterOfIndex(newIndex)?.popUntilRoot();
      } else {
        widget.tabsRouter.setActiveIndex(newIndex);
      }
    }
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    required this.onTap,
    required this.icon,
    required this.inactiveIcon,
    required this.label,
    required this.isActive,
  });

  final VoidCallback onTap;
  final SvgPicture icon;
  final SvgPicture inactiveIcon;
  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isActive) icon else inactiveIcon,
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isActive ? Colors.black : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
