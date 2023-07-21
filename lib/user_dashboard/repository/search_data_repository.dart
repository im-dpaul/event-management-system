import 'dart:convert';
import 'package:event_management_system/main.dart';
import 'package:event_management_system/user_dashboard/models/event_category_model.dart';
import 'package:event_management_system/user_dashboard/models/search_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class SearchDataReposirtoy {
  final String allEventUrl =
      'https://ems.antino.ca/api/user/admin/event/search?search=';
  final String eventCategoryUrl =
      'https://ems.antino.ca/api/user/admin/event/eventCategory';

  Future<EventCategoryModel?> eventCategory(String category) async {
    var response = await Dio().get(
      eventCategoryUrl,
      data: {"eventCategory": category},
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      ),
    );
    var data = response.data;
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('$category Event Data fetched Succssfully');
        print(data);
      }
      return EventCategoryModel.fromJson(data);
    } else {
      if (kDebugMode) {
        print('Failed to fetch $category Event Data');
      }
      return null;
    }
  }

  Future<SearchModel?> allEvent(String query) async {
    var response = await http.get(
      Uri.parse(allEventUrl + query),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('All Event Data fetched Succssfully');
        print(data);
      }
      return SearchModel.fromJson(data);
    } else {
      if (kDebugMode) {
        print('Failed to fetch All Event Data');
      }
      return null;
    }
  }
}
