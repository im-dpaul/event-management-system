// To parse this JSON data, do
//
//     final eventModel = eventModelFromJson(jsonString);

import 'dart:convert';

EventModel eventModelFromJson(String str) =>
    EventModel.fromJson(json.decode(str));

String eventModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  EventModel({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.featured,
    this.bestEvents,
    this.musicEvents,
  });

  List<Featured>? featured;
  List<BestEvent>? bestEvents;
  List<Featured>? musicEvents;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        featured: List<Featured>.from(
            json["featured"].map((x) => Featured.fromJson(x))),
        bestEvents: List<BestEvent>.from(
            json["bestEvents"].map((x) => BestEvent.fromJson(x))),
        musicEvents: List<Featured>.from(
            json["musicEvents"].map((x) => Featured.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "featured": List<dynamic>.from(featured!.map((x) => x.toJson())),
        "bestEvents": List<dynamic>.from(bestEvents!.map((x) => x.toJson())),
        "musicEvents": List<dynamic>.from(musicEvents!.map((x) => x.toJson())),
      };
}

class BestEvent {
  BestEvent({
    this.id,
    this.tickets,
    this.eventDetails,
  });

  String? id;
  int? tickets;
  List<Featured>? eventDetails;

  factory BestEvent.fromJson(Map<String, dynamic> json) => BestEvent(
        id: json["_id"],
        tickets: json["tickets"],
        eventDetails: List<Featured>.from(
            json["eventDetails"].map((x) => Featured.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "tickets": tickets,
        "eventDetails":
            List<dynamic>.from(eventDetails!.map((x) => x.toJson())),
      };
}

class Featured {
  Featured({
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
  List<String>? slots;
  String? eventDescription;
  String? eventCategory;
  String? eventVenue;
  int? v;
  String? eventFeatureImage;
  bool? featuredEvents;

  factory Featured.fromJson(Map<String, dynamic> json) => Featured(
        id: json["_id"],
        eventName: json["eventName"],
        eventDate: json["eventDate"],
        slots: List<String>.from(json["slots"].map((x) => x)),
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
        "slots": List<dynamic>.from(slots!.map((x) => x)),
        "eventDescription": eventDescription,
        "eventCategory": eventCategory,
        "eventVenue": eventVenue,
        "__v": v,
        "eventFeatureImage": eventFeatureImage,
        "featuredEvents": featuredEvents,
      };
}
