// To parse this JSON data, do
//
//     final storeResponse = storeResponseFromJson(jsonString);

import 'dart:convert';

List<StoreResponse> storeResponseFromJson(String str) =>
    List<StoreResponse>.from(
        json.decode(str).map((x) => StoreResponse.fromJson(x)));

String storeResponseToJson(List<StoreResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreResponse {
  StoreResponse({
    required this.id,
    required this.image,
    required this.name,
    required this.building,
    required this.storeCategory,
  });

  String id;
  String image;
  String name;
  String building;
  String storeCategory;

  factory StoreResponse.fromJson(Map<String, dynamic> json) => StoreResponse(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        building: json["building"],
        storeCategory: json["storeCategory"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "building": building,
        "storeCategory": storeCategory,
      };
}
