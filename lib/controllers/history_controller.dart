import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/address_controller.dart';
import 'package:vinhome_user/controllers/apis/api_path.dart';
import 'package:vinhome_user/models/delivery_timeline.dart';
import 'package:vinhome_user/models/order_history.dart';
import 'package:vinhome_user/models/response/order_history_detail.dart';
import 'package:vinhome_user/utils/ResponseUtil.dart';
import 'package:vinhome_user/utils/date.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/response/address.dart';
import '../models/response/order_history_modael.dart';

class HistoryController extends GetxController {
  late SharedPreferences prefs;

  late OrderHistoryDetail orderHistoryDetail;

  var isLoading = false;
  int currentStep = 0;
  final TextEditingController orderIdTextController = TextEditingController();
  late AddressController addressController = Get.find<AddressController>();
  late List<OrderHistory> orderHistories = [];
  late List<OrderHistoryModel> orderHistoriesResponse = [];
  late List<DeliveryTimeLine> deliveryTimeLine = [
    DeliveryTimeLine('Đặt hàng thành công', '---', 'assets/images/3338721.png'),
    DeliveryTimeLine('Đang xử lý', '---', 'assets/images/dangxuly.png'),
    DeliveryTimeLine(
        'Tài xế nhận đơn', '---', 'assets/images/taixenhandon.png'),
    DeliveryTimeLine(
        'Lấy hàng thành công', '---', 'assets/images/layhangthanhcong.png'),
    DeliveryTimeLine('Đang giao', '---', 'assets/images/danggiao.png'),
    DeliveryTimeLine('Hoàn thành', '---', 'assets/images/hoanthanh.png'),
  ];

  void setitemTolocalStorage(OrderHistory orderHistory) async {
    prefs = await SharedPreferences.getInstance();
    orderHistories.add(orderHistory);
    prefs.setString('orderHistoryIds', orderHistoryToJson(orderHistories));
    update();
  }

  void getitemFromLocalStorage() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString('orderHistoryIds') != null) {
      orderHistories =
          orderHistoryFromJson(prefs.getString('orderHistoryIds')!);
      update();
    }
  }

  Future<void> getOrderHistory() async {
    isLoading = true;
    orderHistoriesResponse = [];
    Address? selectedAddress = addressController.addressList
        .firstWhereOrNull((element) => element.isDefault == 1);
    Map<String, dynamic> queryParams = {
      'pageIndex': "1",
      'pageSize': "20",
      'phone': selectedAddress?.soDienThoai
    };
    ResponseUtil.getMapping(
            path: ApiPath.ORDER_HISTORY_BY_PHONE, queryParams: queryParams)
        .then((value) {
      for (var item in json.decode(value.body)) {
        OrderHistoryModel orderResponse = OrderHistoryModel.fromJson(item);
        orderHistoriesResponse.add(orderResponse);
      }
      isLoading = false;
      update();
    });
  }

  Future<int> getOrderHistoryDetail(String id) async {
    print(id);
    isLoading = true;
    int status = 404;
    await ResponseUtil.getDetailMapping(ApiPath.ORDER_HISTORY_DETAIL + id).then(
      (value) {
        print(value.status);
        if (value.status == 200) {
          orderHistoryDetail = orderHistoryDetailFromJson(value.body);
          if (orderHistoryDetail.shipCost == null) {
            orderHistoryDetail.shipCost = 0;
          }
          int j = 0;
          for (var i = 0; i < orderHistoryDetail.listStatusOrder.length; i++) {
            deliveryTimeLine[j++].time =
                dateFormat.format(orderHistoryDetail.listStatusOrder[i].time);
          }
        } else {
          return 404;
        }
        isLoading = false;
        update();

        return 200;
      },
    ).then((value) => {status = value});

    return status;
  }
}
