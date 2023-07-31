import 'dart:convert';

import 'package:vinhome_user/models/response/product_list.dart';

StoreDetailResponse storeDetailResponseFromJson(String str) =>
    StoreDetailResponse.fromJson(json.decode(str));

String storeDetailResponseToJson(StoreDetailResponse data) =>
    json.encode(data.toJson());

class StoreDetailResponse {
  StoreDetailResponse({
    required this.id,
    required this.image,
    required this.name,
    this.description,
    required this.closeTime,
    required this.openTime,
    required this.location,
    required this.listProducts,
  });

  String id;
  String image;
  String name;
  String? description;
  String closeTime;
  String openTime;
  String location;
  List<ListProduct> listProducts;

  factory StoreDetailResponse.fromJson(Map<String, dynamic> json) =>
      StoreDetailResponse(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        closeTime: json["closeTime"],
        openTime: json["openTime"],
        location: json["location"],
        listProducts: List<ListProduct>.from(
            json["listProducts"].map((x) => ListProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
        "closeTime": closeTime,
        "openTime": openTime,
        "location": location,
        "listProducts": List<dynamic>.from(listProducts.map((x) => x.toJson())),
      };
}
