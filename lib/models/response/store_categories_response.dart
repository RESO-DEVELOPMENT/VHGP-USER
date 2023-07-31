// To parse this JSON data, do
//
//     final storeCategoriesResponse = storeCategoriesResponseFromJson(jsonString);

import 'dart:convert';

List<StoreCategoriesResponse> storeCategoriesResponseFromJson(String str) =>
    List<StoreCategoriesResponse>.from(
        json.decode(str).map((x) => StoreCategoriesResponse.fromJson(x)));

String storeCategoriesResponseToJson(List<StoreCategoriesResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StoreCategoriesResponse {
  StoreCategoriesResponse({
    required this.id,
    required this.name,
    required this.listStores,
  });

  String id;
  String name;
  List<ListStore> listStores;

  factory StoreCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      StoreCategoriesResponse(
        id: json["id"],
        name: json["name"]!,
        listStores: List<ListStore>.from(
            json["listStores"].map((x) => ListStore.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "listStores": List<dynamic>.from(listStores.map((x) => x.toJson())),
      };
}

class ListStore {
  ListStore({
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

  factory ListStore.fromJson(Map<String, dynamic> json) => ListStore(
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
