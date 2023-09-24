import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nested/nested.dart';

import '../../domain/bloc/authorization/bloc/authorization_bloc.dart';
import '../../domain/bloc/authorization/cubit/authorization_cubit.dart';
import '../../injectable.dart';
import '../router/router.dart';
import 'authorization_listener.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<AuthorizationCubit>(
          create: (BuildContext context) => getIt.get<AuthorizationCubit>(),
        ),
        BlocProvider<AuthorizationBloc>(
          create: (BuildContext context) => getIt.get<AuthorizationBloc>(),
        ),
      ],
      child: AuthorizationListener(
        child: MaterialApp.router(
          builder: FToastBuilder(),
          debugShowCheckedModeBanner: false,
          locale: const Locale('ru'),
          theme: ThemeData(
            fontFamily: 'Rubik',
          ),
          routerConfig: getIt.get<AppRouter>().config(),
        ),
      ),
    );
  }
}
