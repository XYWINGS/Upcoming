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
    AppConfig _config = getIt.get<AppConfig>();
    _baseUrl = _config.baseAppUrl;
    _api_key = _config.apiKey;
  }

  Future<Response> get(
    String path, {
    required Map<String, dynamic> query,
  }) async {
    try {
      String _url = '$_baseUrl$path';
      Map<String, dynamic> _query = {'api_key': _api_key, 'language': 'en-US'};
      if (query != null) {
        _query.addAll(query);
      }
      return await _dio.get(_url, queryParameters: _query);
    } on DioException catch (e) {
      print('Error in HTTPService.get: $e');
      print('Unable to perform get request');
      throw e;
    }
  }
}
