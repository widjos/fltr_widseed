import 'package:test/util/app_type.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  ApiManager._privateContructor();
  static final ApiManager shared = ApiManager._privateContructor();


  Future<void> request({
    required String baseUrl,
    required String pathUrl,
    required HttpType type,
    Map<String, dynamic>? bodyParams,
    Map<String, dynamic>? uriParams
  }) async {
    final uri = Uri.http(baseUrl, pathUrl);
    final request  = await http.post(uri);
  }
}