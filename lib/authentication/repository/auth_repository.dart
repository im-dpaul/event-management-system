import 'dart:convert';
import 'package:event_management_system/main.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String signupWithEmailURL = 'https://ems.antino.ca/api/users/register';
String loginWithEmailURL = 'https://ems.antino.ca/api/users/login';
String phoneAuthURL = 'https://ems.antino.ca/api/users/login/phone';
String verifyOtpURL = 'https://ems.antino.ca/api/users/login/verifyOTP';

class AuthRepository {
  Future<String> loginWithEmail(String email, String password) async {
    String result = 'failed';
    if (kDebugMode) {
      print('function called');
    }
    try {
      var response = await http.post(
        Uri.parse(loginWithEmailURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        // UserModel.fromJson(data);
        token = data['data']['token'];
        role = data['data']['user']['role'];
        fName = data['data']['user']['firstName'];
        lName = data['data']['user']['lastName'];
        emailId = data['data']['user']['email'];

        if (kDebugMode) {
          print("token- $token");
        }

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('role', role);
        await prefs.setString('firstName', fName);
        await prefs.setString('lastName', lName);
        await prefs.setString('email', emailId);
        result = 'success';

        Fluttertoast.showToast(msg: 'Welcome Back!');
        // final String? readToken = prefs.getString('token');
        // print(readToken);
      } else {
        if (kDebugMode) {
          print('exception - ${response.body}');
        }
        Fluttertoast.showToast(msg: '${data['error']}!');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return result;
  }

  Future<String> signupWithEmail(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    String result = 'failed';
    if (kDebugMode) {
      print('function called');
    }
    try {
      var response = await http.post(
        Uri.parse(signupWithEmailURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Charset': 'utf-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'firstName': firstName,
          'lastName': lastName
        }),
      );
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        token = data['data']['token'];
        role = data['data']['user']['role'];
        fName = data['data']['user']['firstName'];
        lName = data['data']['user']['lastName'];
        emailId = data['data']['user']['email'];
        if (kDebugMode) {
          print("data- ${data['data']}");
        }
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('role', role);
        await prefs.setString('firstName', fName);
        await prefs.setString('lastName', lName);
        await prefs.setString('email', emailId);
        result = 'success';
        Fluttertoast.showToast(msg: 'Account Created Successfully!');
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

  Future<String> signinWithPhone(String phone) async {
    String result = 'failed';
    if (kDebugMode) {
      print('function called');
    }
    try {
      var response = await http.post(
        Uri.parse(phoneAuthURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phoneNumber': phone,
        }),
      );
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("data- ${data['data']}");
        }
        result = 'success';
      } else {
        if (kDebugMode) {
          print('exception - ${response.body}');
        }
        Fluttertoast.showToast(msg: '${data['error']}');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return result;
  }

  Future<String> verifyOTP(int phone, int otp) async {
    String result = 'failed';
    if (kDebugMode) {
      print('function called');
    }
    try {
      var response = await http.post(
        Uri.parse(verifyOtpURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'phoneNumber': phone,
          'otp': otp,
        }),
      );
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("data- ${data['data']}");
        }
        token = data['data']['token'];
        role = data['data']['user']['role'];
        phoneNum = (data['data']['user']['phoneNumber']).toString();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('role', role);
        await prefs.setString('phone', phoneNum);
        result = 'success';
        Fluttertoast.showToast(msg: 'Welcome Back!');
      } else {
        if (kDebugMode) {
          print('exception - ${response.body}');
        }
        Fluttertoast.showToast(msg: '${data['error']}');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return result;
  }
}
