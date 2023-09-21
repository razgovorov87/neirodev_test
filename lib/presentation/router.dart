import 'package:auto_route/auto_route.dart';
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
      ];
}

final List<AdaptiveRoute> _authorizationRoutes = <AdaptiveRoute>[
  // AdaptiveRoute(
  //   path: '/',
  //   page: AuthorizationFlow.page,
  //   children: <AutoRoute>[
  //     AdaptiveRoute(
  //       path: '',
  //       page: AuthorizationRoute.page,
  //     ),
  //     AdaptiveRoute(
  //       path: 'register',
  //       page: RegisterRoute.page,
  //     ),
  //   ],
  // ),
];

final List<AdaptiveRoute> _mainFlowRoutes = <AdaptiveRoute>[
  AdaptiveRoute(
    path: '/',
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
