// To parse this JSON data, do
//
//     final areaById = areaByIdFromJson(jsonString);

import 'dart:convert';

AreaById areaByIdFromJson(String str) => AreaById.fromJson(json.decode(str));

String areaByIdToJson(AreaById data) => json.encode(data.toJson());

class AreaById {
  AreaById({
    required this.id,
    required this.name,
    required this.listCluster,
  });

  String id;
  String name;
  List<ListCluster> listCluster;

  factory AreaById.fromJson(Map<String, dynamic> json) => AreaById(
        id: json["id"],
        name: json["name"],
        listCluster: List<ListCluster>.from(
            json["listCluster"].map((x) => ListCluster.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "listCluster": List<dynamic>.from(listCluster.map((x) => x.toJson())),
      };
}

class ListCluster {
  ListCluster({
    required this.id,
    required this.name,
    required this.listBuilding,
  });

  String id;
  String name;
  List<ListBuilding> listBuilding;

  factory ListCluster.fromJson(Map<String, dynamic> json) => ListCluster(
        id: json["id"],
        name: json["name"],
        listBuilding: List<ListBuilding>.from(
            json["listBuilding"].map((x) => ListBuilding.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "listBuilding": List<dynamic>.from(listBuilding.map((x) => x.toJson())),
      };
}

class ListBuilding {
  ListBuilding({
    required this.id,
    required this.name,
    required this.hubId,
    required this.longitude,
    required this.latitude,
  });

  String id;
  String name;
  String hubId;
  String longitude;
  String latitude;

  factory ListBuilding.fromJson(Map<String, dynamic> json) => ListBuilding(
        id: json["id"],
        name: json["name"],
        hubId: json["hubId"],
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "hubId": hubId,
        "longitude": longitude,
        "latitude": latitude,
      };
}
