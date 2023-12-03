import 'package:flutter/material.dart';

import 'app/app.dart';
import 'di/setup_dependencies.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();

  runApp(const App());
}
