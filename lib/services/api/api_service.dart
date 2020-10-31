class ApiService {
  static final _instance = ApiService._internal();

  ApiService._internal();

  static ApiService getInstance() {
    return _instance;
  }
}
