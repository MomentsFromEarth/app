import 'package:dio/dio.dart';
import '../auth/auth_service.dart';

class ApiService {
  static final _instance = ApiService._internal();

  static final Dio _dio = Dio();
  static final String _apiEndpoint = "https://api.momentsfrom.earth";

  ApiService._internal() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      options.headers.addAll({
        'Accept': 'application/json',
        'Authorization': await ApiService._bearerToken(),
        'Content-Type': 'application/json'
      });
      return options;
    }));
  }

  static Future<String> _bearerToken() async {
    var token = await AuthService.getInstance().token();
    return "Bearer $token";
  }

  static ApiService getInstance() {
    return _instance;
  }

  Future<Response> get(String path, {Map<String, dynamic> queryParameters}) async {
    return await _dio.get(formatApiUrl(path), queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic> queryParameters}) async {
    return await _dio.post(formatApiUrl(path), data: data, queryParameters: queryParameters);
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic> queryParameters}) async {
    return await _dio.put(formatApiUrl(path), data: data, queryParameters: queryParameters);
  }

  Future<Response> delete(String path, {dynamic data, Map<String, dynamic> queryParameters}) async {
    return await _dio.delete(formatApiUrl(path), data: data, queryParameters: queryParameters);
  }

  String formatApiUrl(String path) {
    return "$_apiEndpoint$path";
  }
}
