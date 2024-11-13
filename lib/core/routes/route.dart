import 'package:flutter/material.dart';

import '../../features/main_app/splash_screen.dart';
import '../../features/weather/home_screen.dart';

class RouteList {
  static const String splash = '/splash';
  static const String home = '/home';
}

class Routes {
  static Route getRouteGenerate(RouteSettings settings) {
    var routingData = settings.name;
    final arguments = settings.arguments;

    switch (routingData) {
      case RouteList.splash:
        return _buildRoute(
          settings,
          (_) => SplashScreen(),
        );

      case RouteList.home:
        return _buildRoute(
          settings,
          (_) => HomeScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute([String message = 'Page not founds']) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Text(message),
        ),
      );
    });
  }

  static MaterialPageRoute<T> _buildRoute<T>(
    RouteSettings settings,
    WidgetBuilder builder, {
    bool fullscreenDialog = false,
  }) =>
      MaterialPageRoute(
        settings: settings,
        builder: builder,
        fullscreenDialog: fullscreenDialog,
      );
}
