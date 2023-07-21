import 'dart:convert';

import 'package:event_management_system/main.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class CancelBookingRepository {
  final cancelBookingURL = 'https://ems.antino.ca/api/booking/cancel';

  Future<String> cancelBooking(String bookingID) async {
    String result = 'failed';
    print('api call');

    final response = await post(
      Uri.parse(cancelBookingURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        {
          'bookingId': bookingID,
        },
      ),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("data- ${data['data']}");
      }
      result = "success";
      Fluttertoast.showToast(msg: 'Booking cancelled successfully');
    } else {
      if (kDebugMode) {
        print('exception - ${response.body}');
        Fluttertoast.showToast(msg: '${data['error']}');
      }
    }
    return result;
  }
}
