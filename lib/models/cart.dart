// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    this.id,
    this.phoneNumber,
    required this.total,
    this.storeId,
    this.menuId,
    this.buildingId,
    this.buildingName,
    this.note,
    this.fullName,
    this.modeId,
    this.serviceId,
    this.deliveryTimeId,
    required this.orderDetail,
    this.payments,
  });

  String? id;
  String? phoneNumber;
  int total;
  String? storeId;
  String? menuId;
  String? buildingId;
  String? buildingName;
  String? note;
  String? fullName;
  String? modeId;
  String? serviceId;
  String? deliveryTimeId;
  String? storeName;
  List<OrderDetail> orderDetail;
  List<Payment>? payments;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        phoneNumber: json["phoneNumber"],
        total: json["total"],
        storeId: json["storeId"],
        menuId: json["menuId"],
        buildingId: json["buildingId"],
        note: json["note"],
        fullName: json["fullName"],
        modeId: json["modeId"],
        serviceId: json["serviceId"],
        deliveryTimeId: json["deliveryTimeId"],
        orderDetail: List<OrderDetail>.from(
            json["orderDetail"].map((x) => OrderDetail.fromJson(x))),
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phoneNumber": phoneNumber,
        "total": total,
        "storeId": storeId,
        "menuId": menuId,
        "buildingId": buildingId,
        "note": note,
        "fullName": fullName,
        "modeId": modeId,
        "serviceId": serviceId,
        "deliveryTimeId": deliveryTimeId,
        "orderDetail": List<dynamic>.from(orderDetail.map((x) => x.toJson())),
        "payments": List<dynamic>.from(payments!.map((x) => x.toJson())),
      };
}

class OrderDetail {
  OrderDetail(
      {required this.productId,
      required this.quantity,
      required this.price,
      this.productName,
      this.imageUrl});

  String productId;
  String? productName;
  String? imageUrl;
  String quantity;
  int price;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        productId: json["productId"],
        quantity: json["quantity"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
        "price": price,
      };
}

class Payment {
  Payment({
    required this.type,
  });

  int type;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}
