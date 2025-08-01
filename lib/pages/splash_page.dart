//Packages
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
//Models
import 'package:movie_app/models/app_config.dart';
//Services
import 'package:movie_app/services/http_service.dart';
import 'package:movie_app/services/movie_service.dart';


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
      _setup(context).then((_) {
        widget.onInitialized();
      });
    });
  }

  Future<void> _setup(BuildContext context) async {
    final getIt = GetIt.instance;
    final configFile = await rootBundle.loadString('assets/configs/main.json');
    final configMap = jsonDecode(configFile);

    getIt.registerSingleton<AppConfig>(
      AppConfig(
        apiKey: configMap['API_KEY'],
        baseAppUrl: configMap['BASE_APP_URL'],
        baseImageApiUrl: configMap['BASE_IMAGE_API_URL'],
      ),
    );

    getIt.registerSingleton<HTTPService>(HTTPService());

    getIt.registerSingleton<MovieService>(MovieService());
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
