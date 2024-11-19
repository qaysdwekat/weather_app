import 'package:flutter/material.dart';

class AppNavigate {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get _rootNavigator => Navigator.of(navigatorKey.currentContext!);

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return _rootNavigator.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  static Future pushReplacementNamed(
    String routeName, {
    Object? arguments,
  }) {
      return _rootNavigator.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );
  }
}
