class AmplifyService {
  static final _instance = AmplifyService._internal();

  AmplifyService._internal();

  static AmplifyService getInstance() {
    return _instance;
  }
}
