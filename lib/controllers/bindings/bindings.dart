import 'package:get/get.dart';
import 'package:vinhome_user/controllers/authentication_controller.dart';
import 'package:vinhome_user/controllers/cart_controller.dart';
import 'package:vinhome_user/controllers/history_controller.dart';
import 'package:vinhome_user/controllers/home_controller.dart';
import 'package:vinhome_user/controllers/address_controller.dart';
import 'package:vinhome_user/controllers/product_controller.dart';
import 'package:vinhome_user/controllers/store_controller.dart';

import '../tab_app_controller.dart';
import '../user_controller.dart';

class Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TabAppController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => StoreController());
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => AddressController());
    Get.lazyPut(() => HistoryController());
    Get.lazyPut(() => AuthenticationController());
    Get.lazyPut(() => UserController());
  }
}
