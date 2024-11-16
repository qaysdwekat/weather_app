import 'package:flutter/material.dart';

import '../../core/routes/app_navigate.dart';
import '../../core/routes/route.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: NetworkImage('https://i0.wp.com/randomnerdtutorials.com/wp-content/uploads/2020/05/logo.png'),
              width: width * 0.7,
            ),
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
