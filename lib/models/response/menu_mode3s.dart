// To parse this JSON data, do
//
//     final menuMode3S = menuMode3SFromJson(jsonString);

import 'dart:convert';

import 'package:vinhome_user/models/response/store_response.dart';

MenuMode3S menuMode3SFromJson(String str) =>
    MenuMode3S.fromJson(json.decode(str));

String menuMode3SToJson(MenuMode3S data) => json.encode(data.toJson());

class MenuMode3S {
  List<MenuMode3> menuMode3S;
  List<CategoryInMenuView> categoryInMenuViews;
  List<StoreResponse> stores;

  MenuMode3S({
    required this.menuMode3S,
    required this.categoryInMenuViews,
    required this.stores,
  });

  factory MenuMode3S.fromJson(Map<String, dynamic> json) => MenuMode3S(
        menuMode3S: List<MenuMode3>.from(
            json["menuMode3s"].map((x) => MenuMode3.fromJson(x))),
        categoryInMenuViews: List<CategoryInMenuView>.from(
            json["categoryInMenuViews"]
                .map((x) => CategoryInMenuView.fromJson(x))),
        stores: List<StoreResponse>.from(
            json["stores"].map((x) => StoreResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menuMode3s": List<dynamic>.from(menuMode3S.map((x) => x.toJson())),
        "categoryInMenuViews":
            List<dynamic>.from(categoryInMenuViews.map((x) => x.toJson())),
        "stores": List<dynamic>.from(stores.map((x) => x.toJson())),
      };
}

class CategoryInMenuView {
  String id;
  String image;
  String name;

  CategoryInMenuView({
    required this.id,
    required this.image,
    required this.name,
  });

  factory CategoryInMenuView.fromJson(Map<String, dynamic> json) =>
      CategoryInMenuView(
        id: json["id"],
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
      };
}

class MenuMode3 {
  String id;
  String name;
  DateTime dayFilter;
  String dayOfWeek;

  MenuMode3({
    required this.id,
    required this.name,
    required this.dayFilter,
    required this.dayOfWeek,
  });

  factory MenuMode3.fromJson(Map<String, dynamic> json) => MenuMode3(
        id: json["id"],
        name: json["name"],
        dayFilter: DateTime.parse(json["dayFilter"]),
        dayOfWeek: json["dayOfWeek"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "dayFilter":
            "${dayFilter.year.toString().padLeft(4, '0')}-${dayFilter.month.toString().padLeft(2, '0')}-${dayFilter.day.toString().padLeft(2, '0')}",
        "dayOfWeek": dayOfWeek,
      };
}
