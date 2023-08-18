import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vinhome_user/models/response.dart';

class ResponseUtil extends GetxController {
  final String baseUrl = "";

  static RxBool isLoading = false.obs;
  static late final String? token;

  @override
  onInit() async {
    super.onInit();
  }

  static Future<ResponseModel> getMapping(
      {required String path, required Map<String, dynamic> queryParams}) async {
    try {
      isLoading(true);
      final response = await http
          .get(Uri.parse(path).replace(queryParameters: queryParams), headers: {
        "Content-Type": "application/json",
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        return ResponseModel(response.body, response.statusCode);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
    return ResponseModel(null, 500);
  }

  static Future<ResponseModel> getDetailQueryMapping(
      Map<String, String> queryParams, String path) async {
    try {
      isLoading(true);
      final response = await http.get(
          Uri.parse(path).replace(queryParameters: queryParams),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return ResponseModel(response.body, response.statusCode);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
    return ResponseModel(null, 500);
  }

  static Future<ResponseModel> getDetailMapping(String path) async {
    try {
      isLoading(true);
      final response = await http
          .get(Uri.parse(path), headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return ResponseModel(response.body, response.statusCode);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
    return ResponseModel(null, 500);
  }

  static Future<ResponseModel> postMapping(String path, String body) async {
    try {
      isLoading(true);
      final response = await http.post(Uri.parse(path),
          headers: {"Content-Type": "application/json"}, body: body);

      if (response.statusCode == 200) {
        return ResponseModel(response.body, response.statusCode);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
    return ResponseModel(null, 500);
  }

  static Future<ResponseModel> putMapping(String path, String body) async {
    try {
      isLoading(true);

      final response = await http.put(Uri.parse(path),
          headers: {
            "Content-Type": "application/json",
          },
          body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return ResponseModel(response.body, response.statusCode);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
    return ResponseModel(null, 500);
  }

  static Future<ResponseModel> putQueryParamsMapping(
      Map<String, String> queryParams, String path) async {
    try {
      isLoading(true);
      print(path);
      final response = await http.put(
          Uri.parse(path).replace(queryParameters: queryParams),
          headers: {"Content-Type": "application/json"});
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return ResponseModel(response.body, response.statusCode);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
    return ResponseModel(null, 500);
  }

  static Future<ResponseModel> putIsDefaultMapping(
      String path, String id) async {
    try {
      isLoading(true);
      Map<String, String> queryParams = {
        'id': id,
      };

      final response = await http.put(
          Uri.parse(path).replace(queryParameters: queryParams),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return ResponseModel(response.body, response.statusCode);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
    return ResponseModel(null, 500);
  }

  static Future<int> deleteMapping(
      String path, String pathVariable, String id) async {
    try {
      isLoading(true);
      Map<String, String> queryParams = {
        pathVariable: id,
      };
      final response = await http.delete(
          Uri.parse(path).replace(queryParameters: queryParams),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          });
      if (response.statusCode == 200) {
        return 200;
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
    return 500;
  }

  static Future<ResponseModel> postQueryParamsMapping(
      Map<String, String> queryParams, String path) async {
    try {
      isLoading(true);
      final response = await http.post(
          Uri.parse(path).replace(queryParameters: queryParams),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        return ResponseModel(response.body, response.statusCode);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
    return ResponseModel(null, 500);
  }
}
