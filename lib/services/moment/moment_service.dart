class MomentService {
  static final _instance = MomentService._internal();

  MomentService._internal();

  static MomentService getInstance() {
    return _instance;
  }
}
