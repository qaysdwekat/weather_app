import 'package:flutter/material.dart';

import '../../core/routes/app_navigate.dart';
import '../../core/routes/route.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Weather App'),
          ),
          TextButton(
            onPressed: () {
              AppNavigate.pushReplacementNamed(
                RouteList.home,
              );
            },
            child: Text('Go To Home'),
          )
        ],
      ),
    );
  }
}
