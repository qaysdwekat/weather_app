import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'environments/config/config.dart';
import 'features/main_app/main.dart';
import 'injector/core_injector.dart' as di;
// import 'injector/injection_container.dart' as di;

Future<void> weatherAppRunner(config) async {
  WidgetsFlutterBinding.ensureInitialized();

  Config.setConfig(config);
  await di.init();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ],
  ).then(
    (_) => runApp(WeatherApp()),
  );
}
