import 'dart:convert';
import 'dart:io';
import 'package:event_management_system/main.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

String createSlotURL = 'https://ems.antino.ca/api/slots';
String createEventURL =
    'https://ems.antino.ca/api/user/admin/event/createEvent';
String imageUploadURL = 'https://ems.antino.ca/api/user/admin/event/upload?id=';

class AdminEventRepository {
  Future<String> uploadImage(File? image, String id) async {
    String result = 'failed';
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(imageUploadURL + id),
    );
    request.headers.addAll({
      //'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    });
    request.files.add(await http.MultipartFile.fromPath('image', image!.path));
    var response = await request.send();
    if (kDebugMode) {
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      result = "success";
    } else {
      if (kDebugMode) {
        print('image Upload falseeeeee');
      }
    }
    return result;
  }

  Future<String> addSlot(
    String venue,
    String startTime,
    String endTime,
    String name,
    String price,
    int capacity,
  ) async {
    if (kDebugMode) {
      print('token repo-');
    }
    String result = 'failed';
    if (kDebugMode) {
      print('function called');
    }
    try {
      var response = await http.post(
        Uri.parse(createSlotURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          "venue": venue,
          'startTime': startTime,
          'endTime': endTime,
          'slotName': name,
          'price': price,
          'capacity': capacity,
        }),
      );
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("data- ${data['data']}");
          print("slot id- ${data['data']['slot']['_id']}");
        }
        result = "${data['data']['slot']['_id']}";
        Fluttertoast.showToast(msg: 'Slot added successfully');
      } else {
        if (kDebugMode) {
          print('exception - ${response.body}');
          Fluttertoast.showToast(msg: '${data['error']}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return result;
  }

  Future<String> addEvent({
    required String title,
    required String date,
    required List slots,
    required String description,
    required String category,
    required String venue,
  }) async {
    String result = 'failed';
    if (kDebugMode) {
      print('function called');
    }
    try {
      var response = await http.post(
        Uri.parse(createEventURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          "eventName": title,
          'eventDate': date,
          'slots': slots,
          'eventDescription': description,
          'eventCategory': category,
          'eventVenue': venue,
        }),
      );
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 201) {
        if (kDebugMode) {
          print("data- ${data['data']}");
          print("event id- ${data['data']['_id']}");
        }
        result = "${data['data']['_id']}";
        //result = "success";
        Fluttertoast.showToast(msg: 'Event created successfully');
      } else {
        if (kDebugMode) {
          print('exception - ${response.body}');
          print('exception - ${data['error']}');
          Fluttertoast.showToast(msg: '${data['error']}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return result;
  }
}
