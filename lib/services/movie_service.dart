//Packages
import 'package:get_it/get_it.dart';
//Services
import 'package:movie_app/services/http_service.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HTTPService http;

  MovieService() {
    http = getIt.get<HTTPService>();
  }
}
