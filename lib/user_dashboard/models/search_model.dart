// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.success,
    this.data,
  });

  bool? success;
  List<Datum>? data;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.eventName,
    this.eventDate,
    this.slots,
    this.eventCategory,
    this.featuredEvents,
    this.eventVenue,
    this.eventFeatureImage,
    this.v,
    this.eventDescription,
  });

  String? id;
  String? eventName;
  String? eventDate;
  List<Slot>? slots;
  String? eventCategory;
  bool? featuredEvents;
  String? eventVenue;
  String? eventFeatureImage;
  int? v;
  String? eventDescription;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        eventName: json["eventName"],
        eventDate: json["eventDate"],
        slots: List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
        eventCategory: json["eventCategory"],
        featuredEvents: json["featuredEvents"],
        eventVenue: json["eventVenue"],
        eventFeatureImage: json["eventFeatureImage"],
        v: json["__v"],
        eventDescription: json["eventDescription"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "eventName": eventName,
        "eventDate": eventDate,
        "slots": List<dynamic>.from(slots!.map((x) => x.toJson())),
        "eventCategory": eventCategory,
        "featuredEvents": featuredEvents,
        "eventVenue": eventVenue,
        "eventFeatureImage": eventFeatureImage,
        "__v": v,
        "eventDescription": eventDescription,
      };
}

class Slot {
  Slot({
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

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
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
