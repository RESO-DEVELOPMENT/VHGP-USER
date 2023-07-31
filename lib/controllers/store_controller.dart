import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vinhome_user/controllers/apis/api_path.dart';
import 'package:vinhome_user/models/response/store_detail_response.dart';
import 'package:vinhome_user/models/response/store_response.dart';
import 'package:vinhome_user/utils/ResponseUtil.dart';

import 'home_controller.dart';

class StoreController extends GetxController {
  List<StoreResponse> storeResponses = <StoreResponse>[].obs;
  late StoreDetailResponse storeDetail;
  final HomeController homeController = Get.find<HomeController>();
  var isLoading = false;
  @override
  void onInit() {
    getStores();
    super.onInit();
  }

  Future<void> getStores() async {
    isLoading = true;
    Map<String, String> queryParams = {
      'modeId': '1',
      'page': '1',
      'pageSize': '8'
    };
    ResponseUtil.getMapping(path: ApiPath.MENU_STORE, queryParams: queryParams)
        .then((value) {
      storeResponses = storeResponseFromJson(value.body);
      isLoading = false;
      update();
    });
  }

  Future<void> getStoreById(String id, bool isHome) async {
    print(homeController.menuMode + " menuId");
    isLoading = true;
    Map<String, String> queryParams = {
      'storeId': id,
      'page': '1',
      'pageSize': '100'
    };
    ResponseUtil.getDetailQueryMapping(queryParams,
            "${ApiPath.MENU_STORE_BY_ID}${homeController.menuMode}/products/byStoreId")
        .then((value) {
      storeDetail = storeDetailResponseFromJson(value.body);
      isLoading = false;
      update();
    });
  }
}
