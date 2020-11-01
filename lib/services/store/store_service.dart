class StoreService {
  static final _instance = StoreService._internal();

  StoreService._internal();

  static StoreService getInstance() {
    return _instance;
  }
}
