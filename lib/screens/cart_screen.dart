import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinhome_user/controllers/address_controller.dart';
import 'package:vinhome_user/controllers/cart_controller.dart';
import 'package:vinhome_user/controllers/history_controller.dart';
import 'package:vinhome_user/utils/money_format.dart';
import 'package:vinhome_user/widgets/tab_title_uncount.dart';
import '../../common/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../controllers/home_controller.dart';
import '../utils/date.dart';
import '../widgets/cart_add_product.dart';
import '../widgets/user_information.dart';
import 'routes/routes.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.find<CartController>();

  final HistoryController historyController = Get.find<HistoryController>();

  final HomeController homeController = Get.find<HomeController>();

  late String deliveryMode = "GIAO NHANH 30 PHÚT";

  final String deliveryMode2 = "GIAO HÀNG TRONG NGÀY";

  @override
  void initState() {
    cartController.quantity = 0;
    if (homeController.modeId == 2) {
      deliveryMode = deliveryMode2;
      cartController.initOptionTime();
    } else if (homeController.modeId == 3) {
      cartController.initOptionTime();
      deliveryMode = homeController.deliveryTimeMode3;
    } else {
      cartController.deliveryTime =
          "${dateFormat.format(DateTime.now().add(const Duration(minutes: 20)))} - ${dateFormat.format(DateTime.now().add(const Duration(minutes: 30)))}";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Giỏ hàng',
        ),
      ),
      body: GetBuilder<CartController>(
        builder: (controller) => Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Giao đến',
                              style: Get.textTheme.titleSmall,
                            ),
                            Text(
                              '${cartController.cart.buildingName}, ${cartController.areaName} Vinhomes GP',
                              style: Get.textTheme.titleMedium,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Được giao từ',
                                    style: Get.textTheme.titleSmall),
                                Text('${cartController.cart.storeName}',
                                    style: Get.textTheme.titleMedium),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hình thức giao hàng',
                                    style: Get.textTheme.titleSmall),
                                Text(deliveryMode,
                                    style: Get.textTheme.titleMedium),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Thời gian giao dự kiến',
                                    style: Get.textTheme.titleSmall),
                                homeController.modeId != 1
                                    ? GetBuilder<CartController>(
                                        builder: (controller) => Column(
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.45,
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (cartController
                                                      .optionTimeList.isEmpty) {
                                                    showOptionTimesEmptyAlertDialog(
                                                        context);
                                                  } else {
                                                    cartController
                                                        .changeOptionTime(0);
                                                    showCupertinoModalPopup(
                                                        context: context,
                                                        builder: (context) =>
                                                            buildTimePickerPicker());
                                                  }
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: Colors.grey)),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(cartController
                                                            .deliveryTime),
                                                        const Row(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8.0),
                                                              child:
                                                                  VerticalDivider(
                                                                color:
                                                                    Colors.grey,
                                                                thickness: 1,
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .keyboard_arrow_down,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Text(
                                        '${dateFormat.format(DateTime.now().add(const Duration(minutes: 20)))} - ${dateFormat.format(DateTime.now().add(const Duration(minutes: 30)))}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    TabTitleUnCount(
                        title: "Thông tin người nhận",
                        actionText: "Thay đổi",
                        seeAll: () => Get.toNamed(Routes.address)),
                    GetBuilder<AddressController>(
                        builder: (controller) => _buildInformation(context)),
                    const TabTitleUnCount(title: "Tóm tắt đơn hàng"),
                    _buildOrderProductDetail(),
                    _buildeDelivery(context),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tiền hàng:',
                                  style: Get.textTheme.titleMedium),
                              Text(viCurrency.format(cartController.cart.total),
                                  style: Get.textTheme.titleMedium),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Phí giao hàng:',
                                    style: Get.textTheme.titleMedium),
                                Text(
                                    viCurrency.format(
                                      cartController.deliveryFee,
                                    ),
                                    style: Get.textTheme.titleMedium),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Phí dịch vụ',
                                  style: Get.textTheme.titleMedium),
                              Text(
                                  viCurrency.format(cartController.isCheck
                                      ? cartController.servicesFee
                                      : 0),
                                  style: Get.textTheme.titleMedium),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            GetBuilder<CartController>(
              builder: (controller) => Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/money.png',
                                height: 35,
                              ),
                              const Text('Tiền mặt'),
                              const ImageIcon(
                                AssetImage("assets/images/arrow_user.png"),
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tổng cộng:',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                viCurrency.format(cartController.cart.total +
                                    cartController.deliveryFee),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        if ((controller.optionTimeList.isEmpty &&
                                homeController.modeId != 1) ||
                            cartController.deliveryTime == "Chọn khung giờ")
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: const Text(
                              "Chưa chọn khung giờ giao hàng",
                              style: TextStyle(
                                  color: Color.fromRGBO(217, 48, 37, 1)),
                            ),
                          ),
                        InkWell(
                          onTap: (controller.optionTimeList.isEmpty &&
                                      homeController.modeId != 1) ||
                                  controller.cart.orderDetail.isEmpty
                              ? null
                              : () {
                                  if (cartController.cart.fullName == null ||
                                      cartController.cart.fullName == '' ||
                                      cartController.cart.phoneNumber == null ||
                                      cartController.cart.phoneNumber == '' ||
                                      cartController.deliveryTime ==
                                          "Chọn khung giờ") {
                                    showErrorAlertDialog(context);
                                  } else {
                                    builderConfirmOrder(context);
                                  }
                                },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 15),
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
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: (controller
                                                    .optionTimeList.isEmpty &&
                                                homeController.modeId != 1) ||
                                            controller.cart.orderDetail.isEmpty
                                        ? [
                                            Color.fromRGBO(228, 227, 227, 1),
                                            Color.fromRGBO(194, 192, 192, 1)
                                          ]
                                        : [
                                            primary,
                                            primary2,
                                          ])),
                            child: Text('Đặt hàng',
                                style: Get.textTheme.titleLarge?.copyWith(
                                    color: Get.theme.colorScheme.background)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GetBuilder<CartController> _buildOrderProductDetail() {
    return GetBuilder<CartController>(
      builder: (controller) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.cart.orderDetail.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 48,
                  width: 48,
                  child: CachedNetworkImage(
                    imageUrl: controller.cart.orderDetail[index].imageUrl ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'x${cartController.cart.orderDetail[index].quantity}',
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${cartController.cart.orderDetail[index].productName}',
                            style: Get.textTheme.bodyMedium,
                            overflow: TextOverflow.clip,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: TextButton(
                              onPressed: () {
                                cartController.showUpdateQuantity(cartController
                                    .cart.orderDetail[index].productId);
                                _showUpdateProduct(context,
                                    cartController.cart.orderDetail[index]);
                              },
                              child: Text(
                                'Chỉnh sửa',
                                style: Get.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
                Text(
                  viCurrency.format(controller.cart.orderDetail[index].price),
                  style: Get.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card _buildInformation(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              UserInformation(
                cartController: cartController,
                label: 'Tên người nhận',
                value: cartController.cart.fullName ?? '',
                faIcon: FontAwesomeIcons.solidUser,
              ),
              UserInformation(
                cartController: cartController,
                label: 'Số điện thoại',
                value: cartController.cart.phoneNumber ?? '',
                faIcon: FontAwesomeIcons.phone,
              ),
              InkWell(
                onTap: () => _showWarning(context),
                child: UserInformation(
                  cartController: cartController,
                  label: 'Lưu ý',
                  value: cartController.cart.note ?? '',
                  faIcon: FontAwesomeIcons.clipboard,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GetBuilder _buildeDelivery(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: cartController.isCheck,
                    onChanged: (bool? value) {
                      cartController.setCheck();
                    },
                  ),
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://cdn-icons-png.flaticon.com/512/2844/2844235.png',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hỏa tốc',
                          style: Get.textTheme.titleMedium,
                        ),
                        Text(
                            'Đơn hàng của bạn đang được ưu tiên để tài xế giao sớm nhất.',
                            style: Get.textTheme.bodySmall)
                      ],
                    ),
                  ),
                ],
              ),
              Text(viCurrency.format(cartController.servicesFee),
                  style: Get.textTheme.titleSmall),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> _showUpdateProduct(BuildContext context, dynamic product) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GetBuilder<CartController>(
          builder: (controller) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            title: const Text(
              "Cập nhật giỏ hàng",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.productName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(82, 182, 91, 1)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        viCurrency.format(product.price),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(82, 182, 91, 1)),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: MediaQuery.of(context).size.width / 2,
                      child: CartAddProduct(
                        product: product,
                        isCartScreen: true,
                      ),
                    )
                  ],
                )),
            actions: <Widget>[
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (cartController.quantity >= 1) {
                      cartController.changeQuantity(product.productId);
                    } else {
                      cartController.deleteProduct(product.productId);
                    }

                    Navigator.of(context).pop();
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
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: cartController.quantity >= 1
                                  ? [
                                      primary,
                                      primary2,
                                    ]
                                  : [
                                      Color.fromRGBO(237, 55, 116, 1),
                                      Color.fromRGBO(237, 55, 116, 1),
                                    ])),
                      child: cartController.quantity >= 1
                          ? Text(
                              'Cập nhật giỏ hàng',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: "SF Bold",
                              ),
                            )
                          : Text(
                              'Hủy',
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

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.blue;
  }

  Future<String?> _showWarning(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          title: const Text("Lưu ý đặc biệt"),
          content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: cartController.noteController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                  ),
                ),
              )),
          actions: <Widget>[
            Center(
              child: GestureDetector(
                onTap: () {
                  cartController.createNote();
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
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
                            primary,
                            primary2,
                          ])),
                  child: const Text(
                    'Xác nhận',
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
        );
      },
    );
  }

  Future<String?> showAlertDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/successful.gif",
                    width: 300, fit: BoxFit.cover),
                Text("Đặt hàng thành công", style: Get.textTheme.titleMedium),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Mã đơn hàng của bạn là ",
                        style: Get.textTheme.titleSmall,
                      ),
                      GetBuilder<CartController>(
                        builder: (controller) => Text(
                            cartController.deliveryCode,
                            style: Get.textTheme.titleSmall),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Bạn có thể dùng nó để theo dõi đơn hàng của mình.',
                      textAlign: TextAlign.center,
                      style: Get.textTheme.titleSmall),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: GestureDetector(
                onTap: () {
                  Get.back();
                  Get.offNamed(Routes.historyDetail);
                  HistoryController historyController =
                      Get.find<HistoryController>();
                  historyController
                      .getOrderHistoryDetail(cartController.deliveryCode);
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
                              sucessButtonPrimary,
                              sucessButtonSecondary,
                            ])),
                    child: Text('Xem đơn hàng',
                        style: Get.textTheme.titleMedium?.copyWith(
                            color: Get.theme.colorScheme.background)),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String?> builderConfirmOrder(BuildContext parentContext) {
    int _start = 10;
    return showDialog<String>(
      context: parentContext,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              --_start;
            });
            if (_start == 0) {
              Get.back();
              cartController.submitOrder().then((value) {
                if (!cartController.isLoading) {
                  if (cartController.status == 200) {
                    showAlertDialog(parentContext);
                  } else {
                    showErrorAlertDialog(parentContext);
                  }
                }
              });
            }
          });
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                          "Đơn hàng sẽ được gửi đi trong\n$_start giây...",
                          textAlign: TextAlign.center,
                          style: Get.textTheme.titleMedium),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Giao đến",
                          style: Get.textTheme.titleSmall,
                        ),
                        Expanded(
                          child: Text(
                              '${cartController.cart.buildingName}, ${cartController.areaName} Vinhomes GP',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Get.textTheme.titleSmall),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Thời gian dự kiến: ",
                            style: Get.textTheme.titleSmall),
                        Expanded(
                          child: Text(
                            '${cartController.deliveryTime}',
                            style: Get.textTheme.titleSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Tổng tiền đơn hàng: ",
                            style: Get.textTheme.titleSmall),
                        Text(
                            viCurrency.format(cartController.cart.total +
                                cartController.deliveryFee),
                            style: Get.textTheme.titleSmall),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () => Get.back(),
                      child: Text('Trở lại', style: Get.textTheme.titleSmall),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.8,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          cartController.submitOrder().then((value) {
                            if (!cartController.isLoading) {
                              if (cartController.status == 200) {
                                showAlertDialog(parentContext);
                              } else {
                                showErrorAlertDialog(parentContext);
                              }
                            }
                          });
                        },
                        child:
                            Text('Tiếp tục', style: Get.textTheme.titleMedium),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
      },
    );
  }

  Future<String?> showOptionTimesEmptyAlertDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                      "Không có khung giờ phụ hợp. Vui lòng thử lại sau.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
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
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                      "Đã xảy ra lỗi gì đó. Vui lòng thử lại sau.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
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

  Widget buildTimePickerPicker() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: 180,
      child: CupertinoPicker(
        backgroundColor: Colors.white,
        itemExtent: 64,
        onSelectedItemChanged: (value) =>
            cartController.changeOptionTime(value),
        children: cartController.optionTimeList
            .map(
              (e) => Center(
                child: Text(e),
              ),
            )
            .toList(),
      ),
    );
  }
}
