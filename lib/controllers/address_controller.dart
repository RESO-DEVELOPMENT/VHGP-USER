import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinhome_user/controllers/apis/api_path.dart';
import 'package:vinhome_user/controllers/cart_controller.dart';
import 'package:vinhome_user/models/response/area_by_id_response.dart';
import 'package:vinhome_user/models/response/create_address.dart';
import 'package:vinhome_user/utils/ResponseUtil.dart';

import '../models/response/address.dart';
import '../models/response/area_response.dart';
import '../models/response/user.dart';

class AddressController extends GetxController {
  late List<Area> area = [];
  var isLoading = false;
  late AreaById areaById;
  late String building = '';
  var indexCluster = 0;
  bool isSubmit = false;
  late List<Address> addressList = [];
  final CartController cartController = Get.find<CartController>();

  final TextEditingController areaController = TextEditingController();
  final TextEditingController clusterOfBuildingController =
      TextEditingController();
  final TextEditingController buildingController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> getAreaList() async {
    isLoading = true;
    Map<String, String> queryParams = {
      'pageIndex': '1',
      'pageSize': '100',
    };
    ResponseUtil.getDetailQueryMapping(queryParams, ApiPath.AREA).then((value) {
      area = areaFromJson(value.body);
      isLoading = false;

      if (areaController.text == '') {
        areaController.text = area[0].name;
      }
      getAreaById(2);
      update();
    });
  }

  Future<void> getAreaById(int id) async {
    isLoading = true;
    Map<String, String> queryParams = {'areaId': id.toString()};
    ResponseUtil.getDetailQueryMapping(queryParams, ApiPath.AREA_BY_ID)
        .then((value) {
      areaById = areaByIdFromJson(value.body);
      isLoading = false;
      update();
    });
  }

  Future<void> getAddress() async {
    print('Get adress');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String strUser = prefs.getString("user") ?? '';
    User user = User(id: "", name: "", roleId: "", imageUrl: "");
    if (strUser != '') {
      user = userFromJson(strUser);
    }
    isLoading = true;
    Map<String, String> queryParams = {
      'pageIndex': '1',
      'pageSize': '99',
      'AccountId': user.id
    };
    await ResponseUtil.getMapping(
            path: ApiPath.ADDRESS_BUILDING, queryParams: queryParams)
        .then((value) {
      if (value.status == 200) {
        addressList = addressFromJson(value.body);
        print("building");
        Address? defaultAddress =
            addressList.firstWhereOrNull((element) => element.isDefault == 1);

        if (defaultAddress == null) {
          defaultAddress = addressList.first;
        }

        building = defaultAddress.buildingName;

        cartController.cart.fullName = defaultAddress.name;
        cartController.cart.buildingName = defaultAddress.buildingName;
        cartController.cart.buildingId = defaultAddress.buildingId;
        cartController.cart.phoneNumber = defaultAddress.soDienThoai;
        cartController.areaName = defaultAddress.areaName;
        isLoading = false;
        update();
      }
    });
  }

  Future<int> createAddress() async {
    isSubmit = true;

    if (userNameController.text.isEmpty ||
        phoneController.text.length != 10 ||
        buildingController.text.isEmpty) {
      update();
      return -1;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String strUser = prefs.getString("user") ?? '';
    User user = User(id: "", name: "", roleId: "", imageUrl: "");
    if (strUser != '') {
      user = userFromJson(strUser);
    }

    String buildingId = areaById.listCluster[indexCluster].listBuilding
        .firstWhere((element) => element.name == buildingController.text)
        .id;

    CreateAddress address = CreateAddress(
        accountId: user.id,
        buildingId: buildingId,
        isDefault: 0,
        soDienThoai: phoneController.text,
        name: userNameController.text);
    ResponseUtil.postMapping(
            ApiPath.ADDRESS_BUILDING, createAddressToJson(address))
        .then((value) {
      update();
      if (value.status == 500) return 500;
      getAddress();
    });
    isSubmit = true;
    update();
    return 200;
  }

  Future<int> setIsDefault(String id) async {
    ResponseUtil.putIsDefaultMapping(
            '${ApiPath.ADDRESS_BUILDING}/address-default', id)
        .then((value) {
      if (value.status == 500) return 500;
      getAddress();
      update();
    });

    return 200;
  }

  void changeArea(dynamic value) {
    if (areaController.text.isEmpty) {
      areaController.text = area.first.name;
      update();
      return;
    }

    areaController.text = area[value].name;
    getAreaById(value + 2);

    clusterOfBuildingController.clear();
    buildingController.clear();
    update();
  }

  void changeCluster(dynamic value) {
    if (clusterOfBuildingController.text.isEmpty) {
      clusterOfBuildingController.text = areaById.listCluster.first.name;
      indexCluster = 0;
      update();
      return;
    }
    clusterOfBuildingController.text = areaById.listCluster[value].name;
    indexCluster = value;

    buildingController.clear();
    update();
  }

  void changeBuilding(dynamic value) {
    if (buildingController.text.isEmpty) {
      buildingController.text =
          areaById.listCluster[indexCluster].listBuilding.first.name;
      building = areaById.listCluster[indexCluster].listBuilding.first.name;
      update();
      return;
    }
    buildingController.text =
        areaById.listCluster[indexCluster].listBuilding[value].name;
    building = areaById.listCluster[indexCluster].listBuilding[value].name;
    update();
  }
}
