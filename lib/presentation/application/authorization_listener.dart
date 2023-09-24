import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/bloc/authorization/cubit/authorization_cubit.dart';
import '../../domain/models/enum/auth_status.dart';
import '../../injectable.dart';
import '../router/router.dart';
import '../router/router.gr.dart';

class AuthorizationListener extends StatelessWidget {
  const AuthorizationListener({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthorizationCubit, AuthStatus>(
      listener: (BuildContext context, AuthStatus state) {
        final AppRouter router = getIt.get<AppRouter>();
        if (state == AuthStatus.authorized) {
          router.replace(const MainFlow());
        } else {
          router.replace(const AuthorizationRoute());
        }
      },
      child: child,
    );
  }
}
