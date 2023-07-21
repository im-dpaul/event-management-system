import 'dart:convert';

import 'package:event_management_system/main.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class BookingRepository {
  Future<String> createBooking(
    String eventID,
    String slotID,
    int tickets,
  ) async {
    String result = 'failed';
    String bookingURL = 'https://ems.antino.ca/api/booking';

    final response = await post(
      Uri.parse(bookingURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        {
          'eventId': eventID,
          'slotId': slotID,
          'numberOftickets': tickets,
        },
      ),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("data- ${data['data']}");
      }
      result = "success";
      Fluttertoast.showToast(msg: 'Tickets booked successfully');
    } else {
      if (kDebugMode) {
        print('exception - ${response.body}');
        Fluttertoast.showToast(msg: '${data['error']}');
      }
    }

    return result;
  }
}
