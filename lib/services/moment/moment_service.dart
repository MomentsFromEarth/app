import 'package:dio/dio.dart';
import '../api/api_service.dart';

class MomentService {
  static final _instance = MomentService._internal();

  MomentService._internal();

  static final ApiService _api = ApiService.getInstance();

  static MomentService getInstance() {
    return _instance;
  }

  Future<Response> fetch(String id) async {
    return _api.get(momentIdPath(id));
  }

  Future<Response> create(dynamic moment) async {
    return _api.post(momentPath(), data: moment);
  }

  Future<Response> update(String id, dynamic moment) async {
    return _api.put(momentIdPath(id), data: moment);
  }

  Future<Response> delete(String id) async {
    return _api.delete(momentIdPath(id));
  }

  String momentPath() {
    return "/moment";
  }

  String momentIdPath(String id) {
    return "${momentPath()}/$id";
  }
}
