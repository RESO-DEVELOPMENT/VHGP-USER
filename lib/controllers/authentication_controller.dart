import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinhome_user/controllers/apis/api_path.dart';
import 'package:vinhome_user/utils/ResponseUtil.dart';

import '../screens/routes/routes.dart';

class AuthenticationController extends GetxController {
  String isAuthen = "";
  var isLoading = false;

  static late final SharedPreferences prefs;
  static late final String? token;

  Future<void> login(String id, String password) async {
    isLoading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> params = {"id": id, "pass": password};
    ResponseUtil.getMapping(path: ApiPath.LOGIN, queryParams: params)
        .then((value) {
      isAuthen = "FAIL";
      if (value.status == 200) {
        prefs.setString("user", value.body);
        prefs.setString("password", password);
        isAuthen = "OK";
        Get.offAllNamed(Routes.tabScreen);
      }
      isLoading = false;
      update();
    });
  }
}
