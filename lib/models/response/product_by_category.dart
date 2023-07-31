// To parse this JSON data, do
//
//     final productByCategory = productByCategoryFromJson(jsonString);

import 'dart:convert';

import 'product_list.dart';

ProductByCategory productByCategoryFromJson(String str) =>
    ProductByCategory.fromJson(json.decode(str));

String productByCategoryToJson(ProductByCategory data) =>
    json.encode(data.toJson());

class ProductByCategory {
  ProductByCategory({
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

  factory ProductByCategory.fromJson(Map<String, dynamic> json) =>
      ProductByCategory(
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
