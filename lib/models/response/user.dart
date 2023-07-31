// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());
String userToJsonUpdate(User data) => json.encode(data.toJsonUpdate());
String userToJsonUpdateName(User data) => json.encode(data.toJsonUpdateName());

class User {
  String id;
  dynamic password;
  String name;
  String roleId;
  dynamic status;
  dynamic imageUrl;

  User({
    required this.id,
    this.password,
    required this.name,
    required this.roleId,
    this.status,
    required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        password: json["password"],
        name: json["name"],
        roleId: json["roleId"],
        status: json["status"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "name": name,
        "roleId": roleId,
        "status": status,
        "imageUrl": imageUrl
      };

  Map<String, dynamic> toJsonUpdate() =>
      {"id": id, "name": name, "imageUrl": imageUrl};
  Map<String, dynamic> toJsonUpdateName() =>
      {"id": id, "name": name, "imageUrl": null};
}
