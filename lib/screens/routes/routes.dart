import 'package:get/get.dart';
import 'package:vinhome_user/screens/address_screen.dart';
import 'package:vinhome_user/screens/create_address_screen.dart';
import 'package:vinhome_user/screens/authen/login_screen.dart';
import 'package:vinhome_user/screens/cart_screen.dart';
import 'package:vinhome_user/screens/category_detail_screen.dart';
import 'package:vinhome_user/screens/history_detail_screen.dart';
import 'package:vinhome_user/screens/history_screen.dart';
import 'package:vinhome_user/screens/home_screen.dart';
import 'package:vinhome_user/screens/information.screen.dart';
import 'package:vinhome_user/screens/product_detail_screen.dart';
import 'package:vinhome_user/screens/products_category.dart';
import 'package:vinhome_user/screens/store_screen.dart';
import 'package:vinhome_user/screens/tab_screen.dart';

import '../../controllers/bindings/bindings.dart';
import '../change_password.dart';
import '../filter_week_mode3.dart';
import '../register_screen.dart';

class Routes {
  static const langding = "/";
  static const login = "/login";
  static const loginPhone = "/login-phone";
  static const phoneOtp = "/phone-otp";
  static const home = "/home";
  static const tabScreen = "/tabScreen";
  static const categoryDetail = "/categoryDetail";
  static const mode1 = "/mode1CategoryDetail";
  static const store = "/store";
  static const productDetail = "/productDetail";
  static const cart = "/cart";
  static const historyDetail = "/historyDetail";
  static const history = "/historyScreen";
  static const address = "/address";
  static const createAddress = "/createAddress";
  static const productCategory = "/productCategory";
  static const information = "/information";
  static const register = "/register";
  static const fillterMode3 = "/filtter";
  static const changePass = "/changePass";
}

class RouterGenerator {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.tabScreen,
      page: () => TabScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.categoryDetail,
      page: () => CategoryDetailScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.store,
      page: () => StoreScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.productDetail,
      page: () => ProductDetailScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.cart,
      page: () => CartScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.historyDetail,
      page: () => HistoryDetailScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.history,
      page: () => HistoryScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.address,
      page: () => AddressScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.createAddress,
      page: () => CreateAddressScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.productCategory,
      page: () => ProductCategoryScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.information,
      page: () => InformationScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => RegisterScreen(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.fillterMode3,
      page: () => FilterWeekMode3(),
      binding: Binding(),
    ),
    GetPage(
      name: Routes.changePass,
      page: () => ChangePasswordScreen(),
      binding: Binding(),
    ),
  ];
}
