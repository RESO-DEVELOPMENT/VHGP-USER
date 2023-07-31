// To parse this JSON data, do
//
//     final cateroiesResponse = cateroiesResponseFromJson(jsonString);

import 'dart:convert';


CateroiesResponse cateroiesResponseFromJson(String str) =>
    CateroiesResponse.fromJson(json.decode(str));

String cateroiesResponseToJson(CateroiesResponse data) =>
    json.encode(data.toJson());

class CateroiesResponse {
  CateroiesResponse({
    required this.id,
    required this.name,
    this.image,
    required this.startTime,
    required this.endTime,
    required this.listCategoryInMenus,
  });

  String id;
  String name;
  dynamic image;
  int startTime;
  double endTime;
  List<ListCategoryInMenu> listCategoryInMenus;

  factory CateroiesResponse.fromJson(Map<String, dynamic> json) =>
      CateroiesResponse(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        startTime: json["startTime"],
        endTime: json["endTime"]?.toDouble(),
        listCategoryInMenus: List<ListCategoryInMenu>.from(
            json["listCategoryInMenus"]
                .map((x) => ListCategoryInMenu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "startTime": startTime,
        "endTime": endTime,
        "listCategoryInMenus":
            List<dynamic>.from(listCategoryInMenus.map((x) => x.toJson())),
      };
}

class ListCategoryInMenu {
  ListCategoryInMenu({
    required this.id,
    required this.image,
    required this.name,
  });

  String id;
  String image;
  String name;

  factory ListCategoryInMenu.fromJson(Map<String, dynamic> json) =>
      ListCategoryInMenu(
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
