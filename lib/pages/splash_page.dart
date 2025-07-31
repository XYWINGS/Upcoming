import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  final VoidCallback onInitialized;

  const SplashPage({super.key, required this.onInitialized});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upcoming App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Center(
        child : Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash_image.png'),
              fit: BoxFit.contain,
            ),
          ),
        )
      )
    );
  }
}
