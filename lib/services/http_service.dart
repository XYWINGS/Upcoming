//Packages
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
//Models
import 'package:movie_app/models/app_config.dart';

class HTTPService {
  final Dio _dio = Dio();
  final GetIt getIt = GetIt.instance;

  String _baseUrl = '';
  String _api_key = '';

  HTTPService() {
    AppConfig config = getIt.get<AppConfig>();
    _baseUrl = config.baseAppUrl;
    _api_key = config.apiKey;
  }

  Future<Response> get(
    String path, {
    required Map<String, dynamic> query,
  }) async {
    try {
      String url = '$_baseUrl$path';
      Map<String, dynamic> query0 = {'api_key': _api_key, 'language': 'en-US'};
      query0.addAll(query);
          return await _dio.get(url, queryParameters: query0);
    } on DioException catch (e) {
      print('Error in HTTPService.get: $e');
      print('Unable to perform get request');
      rethrow;
    }
  }
}
