import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vinhome_user/controllers/apis/api_path.dart';
import 'package:vinhome_user/controllers/home_controller.dart';
import 'package:vinhome_user/models/response/product_by_category.dart';
import 'package:vinhome_user/models/response/product_response.dart';
import 'package:vinhome_user/utils/ResponseUtil.dart';

import '../models/response/categories_response.dart';
import '../models/response/mode3.dart';

class ProductController extends GetxController {
  var titleScreen = '';
  late ProductResponse productResponse;
  late ProductByCategory productByCategory;
  late List<ListStore> listStore = [];
  var isLoading = false;
  final List<String> titles = ['Lọc nhanh', 'Sắp xếp theo', 'Danh sách'];

  final List<String> listFast = ['Khuyến mãi', 'Quán mới mở'];
  final List<String> listFollow = ['Bán chạy nhất', 'A-Z', 'Z-A'];
  late CateroiesResponse cateroiesResponse;

  final HomeController homeController = Get.find<HomeController>();

  Future<void> getProductDetail(String id) async {
    isLoading = true;
    ResponseUtil.getDetailMapping(ApiPath.PRODUCT_DETAIL + id).then((value) {
      productResponse = productResponseFromJson(value.body);
      update();
      isLoading = false;
    });
  }

  Future<void> getProductByCategory(String categoryId) async {
    isLoading = true;
    Map<String, String> queryParams = {
      'categoryId': categoryId,
      'page': '1',
      'pageSize': '100',
    };
    print(categoryId);
    print("111");
    print(
        "${ApiPath.PRODUCT_BY_CATEGORY}${homeController.menuMode}/products/byCategoryId");
    ResponseUtil.getMapping(
            path:
                "${ApiPath.PRODUCT_BY_CATEGORY}${homeController.menuMode}/products/byCategoryId",
            queryParams: queryParams)
        .then((value) {
      if (value.status == 200) {
        productByCategory = productByCategoryFromJson(value.body);
      } else {
        productByCategory =
            ProductByCategory(id: '', image: '', name: '', listProducts: []);
      }
      update();
      isLoading = false;
    });
  }

  void filterProduct(ListCategoryInMenu value) {
    getProductByCategory(value.id);
  }

  void setTile(String title){
    titleScreen = title;
    update();
  }
}
