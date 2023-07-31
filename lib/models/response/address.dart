// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'dart:convert';

List<Address> addressFromJson(String str) =>
    List<Address>.from(json.decode(str).map((x) => Address.fromJson(x)));

String addressToJson(List<Address> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Address {
  int accountBuildId;
  String accountId;
  String buildingId;
  String buildingName;
  int isDefault;
  String soDienThoai;
  String name;
  String areaId;
  String clusterId;
  String areaName;
  String clusterName;

  Address({
    required this.accountBuildId,
    required this.accountId,
    required this.buildingId,
    required this.buildingName,
    required this.isDefault,
    required this.soDienThoai,
    required this.name,
    required this.areaId,
    required this.clusterId,
    required this.areaName,
    required this.clusterName,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        accountBuildId: json["accountBuildId"],
        accountId: json["accountId"],
        buildingId: json["buildingId"],
        buildingName: json["buildingName"],
        isDefault: json["isDefault"],
        soDienThoai: json["soDienThoai"],
        name: json["name"],
        areaId: json["areaId"],
        clusterId: json["clusterId"],
        areaName: json["areaName"],
        clusterName: json["clusterName"],
      );

  Map<String, dynamic> toJson() => {
        "accountBuildId": accountBuildId,
        "accountId": accountId,
        "buildingId": buildingId,
        "buildingName": buildingName,
        "isDefault": isDefault,
        "soDienThoai": soDienThoai,
        "name": name,
        "areaId": areaId,
        "clusterId": clusterId,
        "areaName": areaName,
        "clusterName": clusterName,
      };
}
