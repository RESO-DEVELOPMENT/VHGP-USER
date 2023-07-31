class ListProduct {
  ListProduct({
    required this.id,
    required this.image,
    required this.name,
    required this.storeId,
    required this.storeName,
    required this.pricePerPack,
    required this.packNetWeight,
    required this.packDes,
    required this.unit,
    required this.minimumDeIn,
    this.maximumQuantity,
    required this.productMenuId,
    required this.status,
  });

  String id;
  String image;
  String name;
  String storeId;
  String storeName;
  int pricePerPack;
  String packDes;
  String unit;
  int minimumDeIn;
  dynamic maximumQuantity;
  dynamic packNetWeight;
  String productMenuId;
  bool status;

  factory ListProduct.fromJson(Map<String, dynamic> json) => ListProduct(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        storeId: json["storeId"],
        storeName: json["storeName"],
        pricePerPack: json["pricePerPack"],
        packDes: json["packDes"],
        packNetWeight: json["packNetWeight"] ?? 0,
        unit: json["unit"],
        minimumDeIn: json["minimumDeIn"],
        maximumQuantity: json["maximumQuantity"] ?? 0,
        productMenuId: json["productMenuId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "storeId": storeId,
        "storeName": storeName,
        "pricePerPack": pricePerPack,
        "packDes": packDes,
        "unit": unit,
        "minimumDeIn": minimumDeIn,
        "productMenuId": productMenuId,
        "status": status,
      };
}
