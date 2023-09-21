import 'package:flutter/material.dart';

import 'injectable.dart';
import 'presentation/application/application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const bool isTesting = bool.fromEnvironment('testing_mode');
  await configureDependencies(isTesting);

  runApp(const Application());
}
