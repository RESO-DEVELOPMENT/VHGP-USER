import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:vinhome_user/common/color.dart';
import 'package:vinhome_user/controllers/apis/api_path.dart';
import 'package:vinhome_user/controllers/history_controller.dart';
import 'package:vinhome_user/controllers/home_controller.dart';
import 'package:vinhome_user/models/cart.dart';
import 'package:vinhome_user/models/order_history.dart';
import 'package:vinhome_user/models/response/order_history_detail.dart';
import 'package:vinhome_user/utils/ResponseUtil.dart';

import '../models/response/order_cart_response.dart';

class CartController extends GetxController {
  final HistoryController historyController = Get.find<HistoryController>();
  final HomeController homeController = Get.find<HomeController>();
  var isLoading = false;
  var isAdd = false;
  var isCheck = false;
  var deliveryFee = 15000;
  var servicesFee = 10000;
  var deliveryCode = "Fail";
  var areaName = "";
  int quantity = 0;
  int status = 500;
  late Cart cart = Cart(orderDetail: [], total: 0);
  var isContinue = true;
  late OrderHistoryDetail orderHistoryDetail;
  var optionTimeList = [];
  late String deliveryTime = "Chọn khung giờ";

  final TextEditingController noteController = TextEditingController();

  Future<void> addProduct(
      dynamic product, bool isCartScreen, BuildContext context) async {
    double totalQuantity = 0;
    isContinue = true;
    if (isCartScreen) {
      for (var orderProduct in cart.orderDetail) {
        if (orderProduct.productId == product.productId) {
          orderProduct.quantity =
              (int.parse(orderProduct.quantity) + 1).toString();
          break;
        }
      }
      getTotal();
      return;
    }

    if (cart.storeId != null && product.storeId != cart.storeId) {
      await showErrorAlertDialog(context);
      if (!isContinue) {
        return;
      }
      cart.orderDetail.clear();
    }
    if (cart.orderDetail.isEmpty) {
      cart.storeName = product.storeName;
      cart.storeId = product.storeId;
      cart.orderDetail.add(OrderDetail(
          price: product.pricePerPack,
          productId: product.id,
          productName: product.name,
          imageUrl: product.image,
          quantity: 1.toString()));
    } else {
      bool isUpdate = false;
      bool isRun = true;
      for (var orderProduct in cart.orderDetail) {
        try {
          if (product.maximumQuantity.toString() != '0') {
            double _packNetWeight = product.packNetWeight.toDouble() ?? 0;
            totalQuantity = int.parse(orderProduct.quantity) * _packNetWeight;

            totalQuantity += product.packNetWeight;

            if (totalQuantity > product.maximumQuantity) {
              showErrorMaximumQuantityAlertDialog(context);
              return;
            }
          }
        } catch (e) {
          print('catch' + e.toString());
        }
        if (orderProduct.productId == product.id) {
          print("set quan tity");
          orderProduct.quantity =
              (int.parse(orderProduct.quantity) + 1).toString();
          isUpdate = true;
          break;
        }
      }
      if (!isUpdate) {
        print("!isUpdate");
        print(!isUpdate);
        cart.orderDetail.add(OrderDetail(
            price: product.pricePerPack,
            productId: product.id,
            productName: product.name,
            imageUrl: product.image,
            quantity: 1.toString()));
      }
    }
    update();
  }

  void subtractProduct(dynamic product, bool isCartScreen) {
    if (isCartScreen) {
      for (var orderProduct in cart.orderDetail) {
        if (orderProduct.productId == product.productId) {
          if (orderProduct.quantity == '1') {
            cart.orderDetail.remove(orderProduct);
            break;
          }
          orderProduct.quantity =
              (int.parse(orderProduct.quantity) - 1).toString();
          break;
        }
      }
      getTotal();
      return;
    }
    for (var orderProduct in cart.orderDetail) {
      if (orderProduct.quantity == '1') {
        cart.orderDetail.remove(orderProduct);
        break;
      }
      if (orderProduct.productId == product.id) {
        orderProduct.quantity =
            (int.parse(orderProduct.quantity) - 1).toString();
        break;
      }
    }
    update();
  }

  void getTotal() {
    cart.note = '';
    cart.total = 0;
    for (var orderProduct in cart.orderDetail) {
      cart.total += orderProduct.price * int.parse(orderProduct.quantity);
    }
    update();
  }

  Future<void> submitOrder() async {
    isLoading = true;
    cart.deliveryTimeId = homeController.modeId == 1 ? "1" : "2";
    cart.modeId = homeController.modeId.toString();
    cart.menuId = homeController.menuMode;
    cart.serviceId = isCheck ? "1" : "2";
    cart.id = "";
    List<Payment> payments = [Payment(type: 0)];
    cart.payments = payments;

    await ResponseUtil.postMapping(ApiPath.CREATE_ORDER, cartToJson(cart))
        .then((value) {
      try {
        OrderCartResponse orderCartResponse =
            orderCartResponseFromJson(value.body);

        deliveryCode = orderCartResponse.data.id;

        historyController.setitemTolocalStorage(
            OrderHistory(id: deliveryCode, price: cart.total.toString()));
        cart.orderDetail = [];
        cart.storeId = null;
      } catch (e) {
        e.printInfo();
      }
      "Fail" == deliveryCode ? status = 500 : status = 200;
      isLoading = false;
      update();
    });
  }

  void createNote() {
    cart.note = noteController.text;
    noteController.clear();
    update();
  }

  void setCheck() {
    isCheck = !isCheck;
    isCheck ? cart.total += servicesFee : cart.total -= servicesFee;
    update();
  }

  Future<String?> showErrorMaximumQuantityAlertDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/error.png",
                      width: 300, fit: BoxFit.cover),
                  const Text(
                    "Oops...!",
                    style: TextStyle(
                        color: Color.fromRGBO(237, 55, 116, 1),
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Bạn đã vượt quá số lượng cho phép.",
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(2, 4),
                                blurRadius: 5,
                                spreadRadius: 2)
                          ],
                          gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color.fromRGBO(237, 55, 116, 1),
                                Color.fromRGBO(237, 55, 116, 1),
                              ])),
                      child: const Text(
                        'Đóng',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontFamily: "SF Bold",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String?> showErrorAlertDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/delete-cart.jpg",
                      width: 300, fit: BoxFit.cover),
                  const Text(
                    "Bạn muốn đặt món ở cửa hàng này?",
                    style: TextStyle(
                        color: primary,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                  ),
                  const Text(
                    "Nhưng những món bạn đã chọn từ cửa hàng trước sẽ bị xóa khỏi giỏ hàng nhé.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.8,
                    child: GestureDetector(
                      onTap: () {
                        isContinue = false;
                        Get.back();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: const Offset(2, 4),
                                  blurRadius: 5,
                                  spreadRadius: 2)
                            ],
                            gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromRGBO(170, 178, 189, 1),
                                  Color.fromRGBO(209, 208, 208, 1),
                                ])),
                        child: const Text(
                          'Trở lại',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: "SF Bold",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.8,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.shade200,
                                  offset: const Offset(2, 4),
                                  blurRadius: 5,
                                  spreadRadius: 2)
                            ],
                            gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromRGBO(237, 55, 116, 1),
                                  Color.fromRGBO(237, 55, 116, 1),
                                ])),
                        child: const Text(
                          'Tiếp tục',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: "SF Bold",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void initOptionTime() {
    // check mode 2 sau 20h ko giao
    // mode 3 giao binh thuopg time = 0
    deliveryTime = "Chọn khung giờ";
    print("initOptionTime");
    optionTimeList.clear();
    int time = DateTime.now().hour;

    if (homeController.modeId == 3) {
      time = 0;
    }
    if (time <= 20) {
      while (true) {
        int nextTime = time + 2;
        String dateTime = "$time:00- $nextTime:00";
        optionTimeList.add(dateTime);
        time = nextTime;
        if (time >= 20) {
          return;
        }
      }
    }
    print(optionTimeList.length);
  }

  void changeOptionTime(int index) {
    deliveryTime = optionTimeList[index];
    update();
  }

  void subtract() {
    quantity -= 1;
    print(quantity);
    update();
  }

  void add() {
    quantity += 1;
    update();
  }

  void changeQuantity(String productId) {
    for (var orderProduct in cart.orderDetail) {
      if (orderProduct.productId == productId) {
        orderProduct.quantity = quantity.toString();

        break;
      }
    }
    getTotal();
    update();
  }

  void deleteProduct(String productId) {
    for (var orderProduct in cart.orderDetail) {
      if (orderProduct.productId == productId) {
        cart.orderDetail.remove(orderProduct);
        break;
      }
    }
    getTotal();
    update();
  }

  void showUpdateQuantity(String productId) {
    quantity = int.parse(cart.orderDetail
        .firstWhere(
          (element) => element.productId == productId,
          orElse: () =>
              OrderDetail(productId: 'productId', quantity: '0', price: 1),
        )
        .quantity);
    getTotal();
    update();
  }
}
