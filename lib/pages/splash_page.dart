import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitialized;

  const SplashPage({super.key, required this.onInitialized});

  // @override
  // SplashPageState createState() => SplashPageState();

  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      widget.onInitialized();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upcoming App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash_image.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
