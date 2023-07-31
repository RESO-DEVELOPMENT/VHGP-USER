// To parse this JSON data, do
//
//     final orderHistoryDetail = orderHistoryDetailFromJson(jsonString);

import 'dart:convert';

OrderHistoryDetail orderHistoryDetailFromJson(String str) => OrderHistoryDetail.fromJson(json.decode(str));

String orderHistoryDetailToJson(OrderHistoryDetail data) => json.encode(data.toJson());

class OrderHistoryDetail {
    OrderHistoryDetail({
        required this.id,
        required this.time,
        required this.total,
        this.shipCost,
        required this.phoneNumber,
        required this.fullName,
        required this.paymentName,
        required this.paymentStatus,
        required this.modeId,
        required this.buildingName,
        required this.serviceId,
        required this.storeName,
        required this.storeBuilding,
        required this.shipperName,
        required this.shipperPhone,
        required this.note,
        required this.timeDuration,
        required this.fromHour,
        required this.toHour,
        this.dayfilter,
        this.messageFail,
        required this.listProInMenu,
        required this.listStatusOrder,
        required this.listShipper,
    });

    String id;
    DateTime time;
    int total;
    dynamic shipCost;
    String phoneNumber;
    String fullName;
    int paymentName;
    int paymentStatus;
    String modeId;
    String buildingName;
    String serviceId;
    String storeName;
    String storeBuilding;
    String shipperName;
    String shipperPhone;
    String note;
    String timeDuration;
    String fromHour;
    String toHour;
    dynamic dayfilter;
    dynamic messageFail;
    List<ListProInMenu> listProInMenu;
    List<ListStatusOrder> listStatusOrder;
    List<dynamic> listShipper;

    factory OrderHistoryDetail.fromJson(Map<String, dynamic> json) => OrderHistoryDetail(
        id: json["id"],
        time: DateTime.parse(json["time"]),
        total: json["total"],
        shipCost: json["shipCost"],
        phoneNumber: json["phoneNumber"],
        fullName: json["fullName"],
        paymentName: json["paymentName"],
        paymentStatus: json["paymentStatus"],
        modeId: json["modeId"],
        buildingName: json["buildingName"],
        serviceId: json["serviceId"],
        storeName: json["storeName"],
        storeBuilding: json["storeBuilding"],
        shipperName: json["shipperName"],
        shipperPhone: json["shipperPhone"],
        note: json["note"],
        timeDuration: json["timeDuration"],
        fromHour: json["fromHour"],
        toHour: json["toHour"],
        dayfilter: json["dayfilter"],
        messageFail: json["messageFail"],
        listProInMenu: List<ListProInMenu>.from(json["listProInMenu"].map((x) => ListProInMenu.fromJson(x))),
        listStatusOrder: List<ListStatusOrder>.from(json["listStatusOrder"].map((x) => ListStatusOrder.fromJson(x))),
        listShipper: List<dynamic>.from(json["listShipper"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "time": time.toIso8601String(),
        "total": total,
        "shipCost": shipCost,
        "phoneNumber": phoneNumber,
        "fullName": fullName,
        "paymentName": paymentName,
        "paymentStatus": paymentStatus,
        "modeId": modeId,
        "buildingName": buildingName,
        "serviceId": serviceId,
        "storeName": storeName,
        "storeBuilding": storeBuilding,
        "shipperName": shipperName,
        "shipperPhone": shipperPhone,
        "note": note,
        "timeDuration": timeDuration,
        "fromHour": fromHour,
        "toHour": toHour,
        "dayfilter": dayfilter,
        "messageFail": messageFail,
        "listProInMenu": List<dynamic>.from(listProInMenu.map((x) => x.toJson())),
        "listStatusOrder": List<dynamic>.from(listStatusOrder.map((x) => x.toJson())),
        "listShipper": List<dynamic>.from(listShipper.map((x) => x)),
    };
}

class ListProInMenu {
    ListProInMenu({
        required this.quantity,
        required this.productName,
        required this.productId,
        required this.price,
    });

    String quantity;
    String productName;
    String productId;
    int price;

    factory ListProInMenu.fromJson(Map<String, dynamic> json) => ListProInMenu(
        quantity: json["quantity"],
        productName: json["productName"],
        productId: json["productId"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "productName": productName,
        "productId": productId,
        "price": price,
    };
}

class ListStatusOrder {
    ListStatusOrder({
        required this.status,
        required this.time,
    });

    int status;
    DateTime time;

    factory ListStatusOrder.fromJson(Map<String, dynamic> json) => ListStatusOrder(
        status: json["status"],
        time: DateTime.parse(json["time"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "time": time.toIso8601String(),
    };
}
