// To parse this JSON data, do
//
//     final myEventsModel = myEventsModelFromJson(jsonString);

import 'dart:convert';

MyEventsModel myEventsModelFromJson(String str) =>
    MyEventsModel.fromJson(json.decode(str));

String myEventsModelToJson(MyEventsModel data) => json.encode(data.toJson());

class MyEventsModel {
  MyEventsModel({
    this.success,
    this.data,
  });

  bool? success;
  List<Data>? data;

  factory MyEventsModel.fromJson(Map<String, dynamic> json) => MyEventsModel(
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
    this.userId,
    this.eventId,
    this.numberOfTickets,
    this.v,
  });

  String? id;
  String? userId;
  EventId? eventId;
  int? numberOfTickets;
  int? v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        userId: json["userId"],
        eventId: EventId.fromJson(json["eventId"]),
        numberOfTickets: json["numberOfTickets"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "eventId": eventId!.toJson(),
        "numberOfTickets": numberOfTickets,
        "__v": v,
      };
}

class EventId {
  EventId({
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
  List<String>? slots;
  String? eventCategory;
  bool? featuredEvents;
  String? eventVenue;
  String? eventFeatureImage;
  int? v;
  String? eventDescription;

  factory EventId.fromJson(Map<String, dynamic> json) => EventId(
        id: json["_id"],
        eventName: json["eventName"],
        eventDate: json["eventDate"],
        slots: List<String>.from(json["slots"].map((x) => x)),
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
        "slots": List<dynamic>.from(slots!.map((x) => x)),
        "eventCategory": eventCategory,
        "featuredEvents": featuredEvents,
        "eventVenue": eventVenue,
        "eventFeatureImage": eventFeatureImage,
        "__v": v,
        "eventDescription": eventDescription,
      };
}
