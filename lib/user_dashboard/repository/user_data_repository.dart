import 'dart:convert';
import 'package:event_management_system/user_dashboard/models/user_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserDataRepository {
  final String userProfileUrl = 'https://ems.antino.ca/api/users/profile';
  final String updateProfileUrl = 'https://ems.antino.ca/api/users/';
  final String changePasswordUrl =
      'https://ems.antino.ca/api/users/changePassword';

  Future<UserProfile> fetchUserProfile() async {
    var userProfile = UserProfile();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      var response = await http.get(
        Uri.parse(userProfileUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      var data = jsonDecode(response.body.toString());

      if (kDebugMode) {
        print('Status Code - ${response.statusCode}');
        print(response.body);
        print(data);
      }
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('User Data fetched Succssfully');
        }
        //userProfile = UserProfile.fromJson(jsonDecode(response.body));
        userProfile.firstName = data['data']['firstName'];
        userProfile.lastName = data['data']['lastName'];
        userProfile.email = data['data']['email'];
        userProfile.phoneNumber = data['data']['phoneNumber'];
      } else {
        if (kDebugMode) {
          print('Failed to fetch User Data');
        }
      }
      return userProfile;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      throw 'Failed to fetch User Data';
    }
  }

  Future<dynamic> updateUserProfile(String firstName, String lastName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (kDebugMode) {
      print('Token : $token');
    }
    try {
      var response = await http.patch(
        Uri.parse(updateProfileUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
          <String, String>{
            "firstName": firstName,
            "lastName": lastName,
            // "email": email,
            // "phoneNumber": phone,
          },
        ),
      );

      if (kDebugMode) {
        print('Status Code - ${response.statusCode}');
        print(response.body);
      }
      if (response.statusCode == 200) {
        //return UserProfile.fromJson(jsonDecode(response.body));

        if (kDebugMode) {
          print('Updated Succssfully');
        }
        return response.statusCode;
      } else {
        //throw Exception('Failed to update User Profile Data!');
        if (kDebugMode) {
          print('Failed to update User Data');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<dynamic> changePassword(String oldPassword, String newPassord) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (kDebugMode) {
      print('token : $token');
    }
    try {
      var response = await http.post(
        Uri.parse(changePasswordUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(
          <String, String>{
            "currentPassword": oldPassword,
            "newPassword": newPassord,
          },
        ),
      );

      if (kDebugMode) {
        print('Status Code - ${response.statusCode}');
        print(response.body);
      }

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Password changed Successfully');
        }
        if (kDebugMode) {
          print(response.body.toString());
        }
        return response.statusCode;
      } else {
        if (kDebugMode) {
          print('Password change Failed');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }
}
