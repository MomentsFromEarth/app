class SearchService {
  static final _instance = SearchService._internal();

  SearchService._internal();

  static SearchService getInstance() {
    return _instance;
  }
}
