// To parse this JSON data, do
//
//     final mode3 = mode3FromJson(jsonString);

import 'dart:convert';

List<Mode3> mode3FromJson(String str) => List<Mode3>.from(json.decode(str).map((x) => Mode3.fromJson(x)));
List<ListStore> listStoreFromJson(String str) => List<ListStore>.from(json.decode(str).map((x) => ListStore.fromJson(x)));
String mode3ToJson(List<Mode3> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mode3 {
    String id;
    String name;
    dynamic image;
    DateTime dayFilter;
    List<ListStore> listStores;

    Mode3({
        required this.id,
        required this.name,
        this.image,
        required this.dayFilter,
        required this.listStores,
    });

    factory Mode3.fromJson(Map<String, dynamic> json) => Mode3(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        dayFilter: DateTime.parse(json["dayFilter"]),
        listStores: List<ListStore>.from(json["listStores"].map((x) => ListStore.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "dayFilter": "${dayFilter.year.toString().padLeft(4, '0')}-${dayFilter.month.toString().padLeft(2, '0')}-${dayFilter.day.toString().padLeft(2, '0')}",
        "listStores": List<dynamic>.from(listStores.map((x) => x.toJson())),
    };
}

class ListStore {
    String id;
    String image;
    String name;
    String building;
    String storeCategory;

    ListStore({
        required this.id,
        required this.image,
        required this.name,
        required this.building,
        required this.storeCategory,
    });

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
