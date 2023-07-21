import 'dart:convert';

import 'package:event_management_system/main.dart';
import 'package:event_management_system/user_dashboard/models/my_events_model.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class MyEventsRepository {
  String myEventsURL = 'https://ems.antino.ca/api/booking';

  Future<MyEventsModel> getMyEvents() async {
    if (kDebugMode) {
      print('api call');
    }
    final response = await get(
      Uri.parse(myEventsURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("success");
        print(data);
      }
      return MyEventsModel.fromJson(data);
    } else {
      if (kDebugMode) {
        print("something went wrong!");
      }
      Fluttertoast.showToast(msg: "Something went wrong, Please try again!");
      return MyEventsModel.fromJson({});
    }
  }
}
