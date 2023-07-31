// To parse this JSON data, do
//
//     final menuMode = menuModeFromJson(jsonString);

import 'dart:convert';

List<MenuMode> menuModeFromJson(String str) => List<MenuMode>.from(json.decode(str).map((x) => MenuMode.fromJson(x)));

String menuModeToJson(List<MenuMode> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuMode {
    String id;
    String name;
    dynamic image;
    dynamic dayFilter;
    int startTime;
    double endTime;
    dynamic listCategoryStoreInMenus;

    MenuMode({
        required this.id,
        required this.name,
        this.image,
        this.dayFilter,
        required this.startTime,
        required this.endTime,
        this.listCategoryStoreInMenus,
    });

    factory MenuMode.fromJson(Map<String, dynamic> json) => MenuMode(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        dayFilter: json["dayFilter"],
        startTime: json["startTime"],
        endTime: json["endTime"]?.toDouble(),
        listCategoryStoreInMenus: json["listCategoryStoreInMenus"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "dayFilter": dayFilter,
        "startTime": startTime,
        "endTime": endTime,
        "listCategoryStoreInMenus": listCategoryStoreInMenus,
    };
}
