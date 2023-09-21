import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injectable.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies(bool isTesting) async => getIt.init(
      environmentFilter: NoEnvOrContains(isTesting ? Environment.test : Environment.dev),
    );
