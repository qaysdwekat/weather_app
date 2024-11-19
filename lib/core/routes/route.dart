import 'package:flutter/material.dart';

import '../../features/main_app/splash_screen.dart';
import '../../features/weather/domain/entities/geo/city_item.dart';
import '../../features/weather/presentation/cities/cities_screen.dart';
import '../../features/weather/presentation/weather/weather_screen.dart';

class RouteList {
  static const String splash = '/splash';
  static const String weather = '/weather';
  static const String cities = 'cities';
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

      case RouteList.weather:
        if (arguments is CityItem) {
          return _buildRoute(
            settings,
            (_) => WeatherScreen(
              city: arguments,
            ),
          );
        }
        return _errorRoute();

      case RouteList.cities:
        return _buildRoute(
          settings,
          (_) => CitiesScreen(),
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
