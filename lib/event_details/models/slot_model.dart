// To parse this JSON data, do
//
//     final slotModel = slotModelFromJson(jsonString);

import 'dart:convert';

SlotModel slotModelFromJson(String str) => SlotModel.fromJson(json.decode(str));

String slotModelToJson(SlotModel data) => json.encode(data.toJson());

class SlotModel {
  SlotModel({
    this.success,
    this.data,
  });

  bool? success;
  List<Data>? data;

  factory SlotModel.fromJson(Map<String, dynamic> json) => SlotModel(
        success: json["success"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    this.id,
    this.slotName,
    this.startTime,
    this.endTime,
    this.price,
    this.capacity,
    this.available,
    this.venue,
    this.v,
  });

  String? id;
  String? slotName;
  String? startTime;
  String? endTime;
  int? price;
  int? capacity;
  int? available;
  String? venue;
  int? v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        slotName: json["slotName"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        price: json["price"],
        capacity: json["capacity"],
        available: json["available"],
        venue: json["venue"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "slotName": slotName,
        "startTime": startTime,
        "endTime": endTime,
        "price": price,
        "capacity": capacity,
        "available": available,
        "venue": venue,
        "__v": v,
      };
}
