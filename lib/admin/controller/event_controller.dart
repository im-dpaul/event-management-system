import 'dart:convert';
import 'package:event_management_system/admin/models/admin_event_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class EventController {
  Future<void> getData() async {
    try {
      Response response = await get(Uri.parse('uri'));
      var data = jsonDecode(response.body);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  List<Map> eventInfo = [
    {
      "eventName": "Arijit Singh Live",
      "shows": "1st",
      "price": 200,
      "capacity": 50,
      "startTime": "10:00 AM",
      "endTime": "11:00 AM",
      "eventUrl": "assets/concert_image/music_one.jpg",
    },
    {
      "eventName": "Arijit Singh Live",
      "shows": "1st",
      "price": 200,
      "capacity": 50,
      "startTime": "10:00 AM",
      "endTime": "11:00 AM",
      "eventUrl": "assets/concert_image/music_two.png",
    },
    {
      "eventName": "Arijit Singh Live",
      "shows": "1st",
      "price": 200,
      "capacity": 50,
      "startTime": "10:00 AM",
      "endTime": "11:00 AM",
      "eventUrl": "assets/concert_image/concert_three.png",
    },
    {
      "eventName": "Arijit Singh Live",
      "shows": "1st",
      "price": 200,
      "capacity": 50,
      "startTime": "10:00 AM",
      "endTime": "11:00 AM",
      "eventUrl": "assets/concert_image/concert_two.png",
    },
    {
      "eventName": "Arijit Singh Live",
      "shows": "1st",
      "price": 200,
      "capacity": 50,
      "startTime": "10:00 AM",
      "endTime": "11:00 AM",
      "eventUrl": "assets/concert_image/concert_one.png",
    },
  ];

  List<AdminEventModel> getEventModel() {
    List<AdminEventModel> list = [];
    for (var event in eventInfo) {
      AdminEventModel eventModel = AdminEventModel(
        eventName: event["eventName"].toString(),
        shows: event["shows"].toString(),
        price: event["price"].toString(),
        capacity: event["capacity"].toString(),
        startTime: event["startTime"].toString(),
        endTime: event["endTime"].toString(),
        eventUrl: event["eventUrl"].toString(),
      );
      list.add(eventModel);
    }
    return list;
  }
}
