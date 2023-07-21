// To parse this JSON data, do
//
//     final eventCategoryModel = eventCategoryModelFromJson(jsonString);

import 'dart:convert';

EventCategoryModel eventCategoryModelFromJson(String str) =>
    EventCategoryModel.fromJson(json.decode(str));

String eventCategoryModelToJson(EventCategoryModel data) =>
    json.encode(data.toJson());

class EventCategoryModel {
  EventCategoryModel({
    this.success,
    this.eventData,
  });

  bool? success;
  List<EventDatum>? eventData;

  factory EventCategoryModel.fromJson(Map<String, dynamic> json) =>
      EventCategoryModel(
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
    this.eventCategory,
    this.featuredEvents,
    this.eventDescription,
    this.eventVenue,
    this.v,
    this.eventFeatureImage,
  });

  String? id;
  String? eventName;
  String? eventDate;
  List<String>? slots;
  String? eventCategory;
  bool? featuredEvents;
  String? eventDescription;
  String? eventVenue;
  int? v;
  String? eventFeatureImage;

  factory EventDatum.fromJson(Map<String, dynamic> json) => EventDatum(
        id: json["_id"],
        eventName: json["eventName"],
        eventDate: json["eventDate"],
        slots: List<String>.from(json["slots"].map((x) => x)),
        eventCategory: json["eventCategory"],
        featuredEvents: json["featuredEvents"],
        eventDescription: json["eventDescription"],
        eventVenue: json["eventVenue"],
        v: json["__v"],
        eventFeatureImage: json["eventFeatureImage"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "eventName": eventName,
        "eventDate": eventDate,
        "slots": List<dynamic>.from(slots!.map((x) => x)),
        "eventCategory": eventCategory,
        "featuredEvents": featuredEvents,
        "eventDescription": eventDescription,
        "eventVenue": eventVenue,
        "__v": v,
        "eventFeatureImage": eventFeatureImage,
      };
}
