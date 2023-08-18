class OrderHistoryModel {
  String? id;
  String? storeName;
  String? buildingName;
  String? customerName;
  String? phone;
  int? total;
  String? note;
  int? shipCost;
  int? paymentName;
  int? paymentStatus;
  String? modeId;
  int? status;
  String? time;
  String? timeDuration;
  String? fromHour;
  String? toHour;
  String? dayfilter;

  OrderHistoryModel(
      {this.id,
      this.storeName,
      this.buildingName,
      this.customerName,
      this.phone,
      this.total,
      this.note,
      this.shipCost,
      this.paymentName,
      this.paymentStatus,
      this.modeId,
      this.status,
      this.time,
      this.timeDuration,
      this.fromHour,
      this.toHour,
      this.dayfilter});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['storeName'];
    buildingName = json['buildingName'];
    customerName = json['customerName'];
    phone = json['phone'];
    total = json['total'];
    note = json['note'];
    shipCost = json['shipCost'];
    paymentName = json['paymentName'];
    paymentStatus = json['paymentStatus'];
    modeId = json['modeId'];
    status = json['status'];
    time = json['time'];
    timeDuration = json['timeDuration'];
    fromHour = json['fromHour'];
    toHour = json['toHour'];
    dayfilter = json['dayfilter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['storeName'] = this.storeName;
    data['buildingName'] = this.buildingName;
    data['customerName'] = this.customerName;
    data['phone'] = this.phone;
    data['total'] = this.total;
    data['note'] = this.note;
    data['shipCost'] = this.shipCost;
    data['paymentName'] = this.paymentName;
    data['paymentStatus'] = this.paymentStatus;
    data['modeId'] = this.modeId;
    data['status'] = this.status;
    data['time'] = this.time;
    data['timeDuration'] = this.timeDuration;
    data['fromHour'] = this.fromHour;
    data['toHour'] = this.toHour;
    data['dayfilter'] = this.dayfilter;
    return data;
  }
}
