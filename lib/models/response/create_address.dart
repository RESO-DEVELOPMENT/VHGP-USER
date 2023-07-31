// To parse this JSON data, do
//
//     final createAddress = createAddressFromJson(jsonString);

import 'dart:convert';

CreateAddress createAddressFromJson(String str) =>
    CreateAddress.fromJson(json.decode(str));

String createAddressToJson(CreateAddress data) => json.encode(data.toJson());

class CreateAddress {
  String accountId;
  String buildingId;
  int isDefault;
  String soDienThoai;
  String name;

  CreateAddress({
    required this.accountId,
    required this.buildingId,
    required this.isDefault,
    required this.soDienThoai,
    required this.name,
  });

  factory CreateAddress.fromJson(Map<String, dynamic> json) => CreateAddress(
        accountId: json["accountId"],
        buildingId: json["buildingId"],
        isDefault: json["isDefault"],
        soDienThoai: json["soDienThoai"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "buildingId": buildingId,
        "isDefault": isDefault,
        "soDienThoai": soDienThoai,
        "name": name,
      };
}
