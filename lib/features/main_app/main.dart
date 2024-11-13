import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../core/routes/app_navigate.dart';
import '../../core/routes/route.dart';
import '../../generated/l10n.dart';
import 'splash_screen.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      onGenerateRoute: Routes.getRouteGenerate,
      navigatorKey: AppNavigate.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
