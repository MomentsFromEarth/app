class StorageService {
  static final _instance = StorageService._internal();

  StorageService._internal();

  static StorageService getInstance() {
    return _instance;
  }
}
