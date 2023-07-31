// To parse this JSON data, do
//
//     final orderCartResponse = orderCartResponseFromJson(jsonString);

import 'dart:convert';

import '../cart.dart';

OrderCartResponse orderCartResponseFromJson(String str) =>
    OrderCartResponse.fromJson(json.decode(str));

String orderCartResponseToJson(OrderCartResponse data) =>
    json.encode(data.toJson());

class OrderCartResponse {
  OrderCartResponse({
    required this.statusCode,
    required this.data,
  });

  String statusCode;
  Data data;

  factory OrderCartResponse.fromJson(Map<String, dynamic> json) =>
      OrderCartResponse(
        statusCode: json["statusCode"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.phoneNumber,
    required this.total,
    required this.storeId,
    required this.menuId,
    required this.buildingId,
    required this.note,
    required this.fullName,
    required this.deliveryTimeId,
    required this.serviceId,
    required this.modeId,
    required this.orderDetail,
    required this.payments,
  });

  String id;
  String phoneNumber;
  int total;
  String storeId;
  String menuId;
  String buildingId;
  String note;
  String fullName;
  String deliveryTimeId;
  String serviceId;
  String modeId;
  List<OrderDetail> orderDetail;
  List<Payment> payments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        phoneNumber: json["phoneNumber"],
        total: json["total"],
        storeId: json["storeId"],
        menuId: json["menuId"],
        buildingId: json["buildingId"],
        note: json["note"],
        fullName: json["fullName"],
        deliveryTimeId: json["deliveryTimeId"],
        serviceId: json["serviceId"],
        modeId: json["modeId"],
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
        "deliveryTimeId": deliveryTimeId,
        "serviceId": serviceId,
        "modeId": modeId,
        "orderDetail": List<dynamic>.from(orderDetail.map((x) => x.toJson())),
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
      };
}
