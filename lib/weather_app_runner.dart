import 'package:flutter/material.dart';

import 'environments/config/config.dart';
import 'features/main_app/main.dart';

Future<void> weatherAppRunner(config) async {
  WidgetsFlutterBinding.ensureInitialized();

  Config.setConfig(config);

  runApp(WeatherApp());
}