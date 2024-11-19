import 'package:flutter/material.dart';

import '../../core/routes/app_navigate.dart';
import '../../core/routes/route.dart';
import 'widgets/animated_splash_child.dart';

class SplashScreen extends StatelessWidget {
  final int duration = 2000;

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF29B2D0),
              Color(0xFF33AADD),
              Color(0xFF2DC8EA),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: AnimatedSplashChild(
          next: () {
            AppNavigate.pushReplacementNamed(
              RouteList.cities,
            );
          },
          imagePath: 'assets/logo/logo_white.png',
          duration: duration,
          animationEffect: SplashScreenTypeConstants.fadeIn,
          boxFit: BoxFit.contain,
          size: Size(size.width * 0.55, size.height * 0.25),
        ),
      ),
    );
  }
}
