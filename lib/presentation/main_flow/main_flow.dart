import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../domain/bloc/add_remove_transactions_bloc/add_remove_transactions_bloc.dart';
import '../../domain/bloc/get_transactions_cubit/transactions_cubit.dart';
import '../../domain/bloc/get_transactions_map_cubit/transactions_map_cubit.dart';
import '../../domain/repository/authorization_repository.dart';
import '../../injectable.dart';
import '../router/router.gr.dart';
import 'home/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';

@RoutePage()
class MainFlow extends StatefulWidget {
  const MainFlow({super.key});

  @override
  State<MainFlow> createState() => _MainFlowState();
}

class _MainFlowState extends State<MainFlow> {
  final TransactionsCubit _transactionCubit = getIt.get<TransactionsCubit>();
  final TransactionsMapCubit _transactionsMapCubit = getIt.get<TransactionsMapCubit>();
  final AddRemoveTransactionsBloc _addRemoveTransactionBloc = getIt.get<AddRemoveTransactionsBloc>();
  final AuthorizationRepository test = getIt.get<AuthorizationRepository>();
  @override
  void dispose() {
    _transactionCubit.close();
    _transactionsMapCubit.close();
    _addRemoveTransactionBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<TransactionsCubit>.value(value: _transactionCubit),
        BlocProvider<TransactionsMapCubit>.value(value: _transactionsMapCubit),
        BlocProvider<AddRemoveTransactionsBloc>.value(value: _addRemoveTransactionBloc),
      ],
      child: AutoTabsRouter(
        routes: const <PageRouteInfo>[
          HomeRoute(),
          AnalyticsRoute(),
        ],
        builder: (BuildContext context, Widget child) => Scaffold(
          body: child,
          bottomNavigationBar: CustomBottomNavigationBar(tabsRouter: context.tabsRouter),
        ),
      ),
    );
  }
}
