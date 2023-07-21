import 'dart:convert';
import 'package:event_management_system/event_details/models/all_event_model.dart';
import 'package:event_management_system/event_details/models/event_model.dart';
import 'package:event_management_system/event_details/models/slot_model.dart';
import 'package:event_management_system/main.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class EventRepository {
  String eventsURL = 'https://ems.antino.ca/api/user/admin/event/explore';
  String getSlotsURL = 'https://ems.antino.ca/api/slots/event?';
  String allEventURL =
      'https://ems.antino.ca/api/user/admin/event/getAllEvents';

  Future<AllEventModel> getAllEvents() async {
    print('token-function-> $token');
    final response = await get(
      Uri.parse(allEventURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("success");
      }
      return AllEventModel.fromJson(data);
    } else {
      if (kDebugMode) {
        print("something went wrong!");
      }
      Fluttertoast.showToast(msg: "Something went wrong, Please try again!");
      return AllEventModel.fromJson({});
    }
  }

  Future<EventModel> getEvents() async {
    print('token-function-> $token');
    final response = await get(
      Uri.parse(eventsURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("success");
      }
      return EventModel.fromJson(data);
    } else {
      if (kDebugMode) {
        print("something went wrong!");
      }
      Fluttertoast.showToast(msg: "Something went wrong, Please try again!");
      return EventModel.fromJson({});
    }
  }

  Future<SlotModel> getEventSlots(String eventID) async {
    final response = await get(
      Uri.parse(getSlotsURL).replace(
        queryParameters: {
          'id': eventID,
        },
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("success /n data${data['data']}");
      }
      return SlotModel.fromJson(data);
    } else {
      if (kDebugMode) {
        print("error- ${data['error']}");
      }
      Fluttertoast.showToast(msg: "Something went wrong, Please try again!");
      return SlotModel.fromJson({});
    }
  }
}
