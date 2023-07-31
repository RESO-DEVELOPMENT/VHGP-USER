// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

ProductResponse productResponseFromJson(String str) =>
    ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) =>
    json.encode(data.toJson());

class ProductResponse {
  ProductResponse({
    required this.id,
    required this.name,
    required this.image,
    required this.unit,
    required this.pricePerPack,
    required this.packNetWeight,
    required this.packDescription,
    required this.maximumQuantity,
    required this.minimumQuantity,
    required this.minimumDeIn,
    required this.description,
    required this.rate,
    required this.storeId,
    required this.storeName,
    required this.storeImage,
    required this.slogan,
    required this.categoryId,
    required this.productCategory,
    required this.createAt,
    this.updateAt,
    this.status,
  });

  String id;
  String name;
  String image;
  String unit;
  int pricePerPack;
  double packNetWeight;
  String packDescription;
  int maximumQuantity;
  double minimumQuantity;
  int minimumDeIn;
  String description;
  int rate;
  String storeId;
  String storeName;
  String storeImage;
  String slogan;
  String categoryId;
  String productCategory;
  String createAt;
  dynamic updateAt;
  dynamic status;

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        unit: json["unit"],
        pricePerPack: json["pricePerPack"],
        packNetWeight: json["packNetWeight"]?.toDouble(),
        packDescription: json["packDescription"],
        maximumQuantity: json["maximumQuantity"],
        minimumQuantity: json["minimumQuantity"]?.toDouble(),
        minimumDeIn: json["minimumDeIn"],
        description: json["description"],
        rate: json["rate"],
        storeId: json["storeId"],
        storeName: json["storeName"],
        storeImage: json["storeImage"],
        slogan: json["slogan"],
        categoryId: json["categoryId"],
        productCategory: json["productCategory"],
        createAt: json["createAt"],
        updateAt: json["updateAt"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "unit": unit,
        "pricePerPack": pricePerPack,
        "packNetWeight": packNetWeight,
        "packDescription": packDescription,
        "maximumQuantity": maximumQuantity,
        "minimumQuantity": minimumQuantity,
        "minimumDeIn": minimumDeIn,
        "description": description,
        "rate": rate,
        "storeId": storeId,
        "storeName": storeName,
        "storeImage": storeImage,
        "slogan": slogan,
        "categoryId": categoryId,
        "productCategory": productCategory,
        "createAt": createAt,
        "updateAt": updateAt,
        "status": status,
      };
}
