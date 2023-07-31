// To parse this JSON data, do
//
//     final categoriesModeResponse = categoriesModeResponseFromJson(jsonString);

import 'dart:convert';

import 'product_list.dart';

CategoriesModeResponse categoriesModeResponseFromJson(String str) =>
    CategoriesModeResponse.fromJson(json.decode(str));

String categoriesModeResponseToJson(CategoriesModeResponse data) =>
    json.encode(data.toJson());

class CategoriesModeResponse {
  CategoriesModeResponse({
    required this.id,
    required this.name,
    this.image,
    this.dayFilter,
    required this.startTime,
    required this.endTime,
    required this.listCategoryStoreInMenus,
  });

  String id;
  String name;
  dynamic image;
  dynamic dayFilter;
  int startTime;
  double endTime;
  List<ListCategoryStoreInMenu> listCategoryStoreInMenus;

  factory CategoriesModeResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesModeResponse(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        dayFilter: json["dayFilter"],
        startTime: json["startTime"],
        endTime: json["endTime"]?.toDouble(),
        listCategoryStoreInMenus: List<ListCategoryStoreInMenu>.from(
            json["listCategoryStoreInMenus"]
                .map((x) => ListCategoryStoreInMenu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "dayFilter": dayFilter,
        "startTime": startTime,
        "endTime": endTime,
        "listCategoryStoreInMenus":
            List<dynamic>.from(listCategoryStoreInMenus.map((x) => x.toJson())),
      };
}

class ListCategoryStoreInMenu {
  ListCategoryStoreInMenu({
    required this.id,
    required this.image,
    required this.name,
     this.status,
    required this.listProducts,
  });

  String id;
  String image;
  String name;
  dynamic status;
  List<ListProduct> listProducts;

  factory ListCategoryStoreInMenu.fromJson(Map<String, dynamic> json) =>
      ListCategoryStoreInMenu(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        status: json["status"],
        listProducts: List<ListProduct>.from(
            json["listProducts"].map((x) => ListProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "status": status,
        "listProducts": List<dynamic>.from(listProducts.map((x) => x.toJson())),
      };
}