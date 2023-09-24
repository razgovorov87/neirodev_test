import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'router.gr.dart';

@singleton
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => <AutoRoute>[
        ..._authorizationRoutes,
        ..._mainFlowRoutes,
        ..._dialogRoutes,
      ];
}

final List<AdaptiveRoute> _authorizationRoutes = <AdaptiveRoute>[
  AdaptiveRoute(
    path: '/',
    page: AuthorizationRoute.page,
  ),
];

final List<AdaptiveRoute> _mainFlowRoutes = <AdaptiveRoute>[
  AdaptiveRoute(
    path: '/main',
    page: MainFlow.page,
    children: <AutoRoute>[
      AdaptiveRoute(
        path: '',
        page: HomeRoute.page,
      ),
      AdaptiveRoute(
        path: 'analytics',
        page: AnalyticsRoute.page,
      ),
    ],
  ),
];

final List<CustomRoute> _dialogRoutes = <CustomRoute>[
  CustomRoute(
    path: '/transaction_info',
    page: TransactionInfoDialog.page,
    opaque: false,
    barrierColor: const Color(0x80000000),
    transitionsBuilder: TransitionsBuilders.fadeIn,
    durationInMilliseconds: 200,
  ),
];
