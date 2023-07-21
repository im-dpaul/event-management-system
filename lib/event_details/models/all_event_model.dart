// To parse this JSON data, do
//
//     final allEventModel = allEventModelFromJson(jsonString);

import 'dart:convert';

AllEventModel allEventModelFromJson(String str) =>
    AllEventModel.fromJson(json.decode(str));

String allEventModelToJson(AllEventModel data) => json.encode(data.toJson());

class AllEventModel {
  AllEventModel({
    this.success,
    this.eventData,
  });

  bool? success;
  List<EventDatum>? eventData;

  factory AllEventModel.fromJson(Map<String, dynamic> json) => AllEventModel(
        success: json["success"],
        eventData: List<EventDatum>.from(
            json["eventData"].map((x) => EventDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "eventData": List<dynamic>.from(eventData!.map((x) => x.toJson())),
      };
}

class EventDatum {
  EventDatum({
    this.id,
    this.eventName,
    this.eventDate,
    this.slots,
    this.eventDescription,
    this.eventCategory,
    this.eventVenue,
    this.v,
    this.eventFeatureImage,
    this.featuredEvents,
  });

  String? id;
  String? eventName;
  String? eventDate;
  List<Slot>? slots;
  String? eventDescription;
  String? eventCategory;
  String? eventVenue;
  int? v;
  String? eventFeatureImage;
  bool? featuredEvents;

  factory EventDatum.fromJson(Map<String, dynamic> json) => EventDatum(
        id: json["_id"],
        eventName: json["eventName"],
        eventDate: json["eventDate"],
        slots: List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
        eventDescription: json["eventDescription"],
        eventCategory: json["eventCategory"],
        eventVenue: json["eventVenue"],
        v: json["__v"],
        eventFeatureImage: json["eventFeatureImage"],
        featuredEvents: json["featuredEvents"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "eventName": eventName,
        "eventDate": eventDate,
        "slots": List<dynamic>.from(slots!.map((x) => x.toJson())),
        "eventDescription": eventDescription,
        "eventCategory": eventCategory,
        "eventVenue": eventVenue,
        "__v": v,
        "eventFeatureImage": eventFeatureImage,
        "featuredEvents": featuredEvents,
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
