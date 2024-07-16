import 'dart:convert';
import 'dart:developer';
import 'package:hire_me/models/registration_model.dart';
import 'package:hire_me/models/user_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'api_routes.dart';

class AuthService {
  Future<LoginResponse?> login(String email, String password) async {
    final body = json.encode({
      'email': email,
      'password': password,
    });

    try {
      final response = await http.post(
        Uri.parse(ApiRoutes.login),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return LoginResponse.fromJson(responseData);
      } else {
        final errorData = json.decode(response.body);
        log('Error: ${errorData['msg']}');
        return null;
      }
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }

  Future<RegistrationResponse?> register(
      String email,
      String password,
      String userName,
      String phone,
      String businessEmail,
      String companyPassword,
      String companyName,
      String businessNumber,
      String address,
      String registerType) async {
    var body = "";
    if (registerType == "jobs") {
      body = json.encode({
        'email': email,
        'password': password,
        'userName': userName,
        'phone': phone,
        'registerType': registerType
      });
    } else {
      body = json.encode({
        'businessEmail': businessEmail,
        'password': companyPassword,
        'companyName': companyName,
        'businessNumber': businessNumber,
        'address': address,
        'registerType': registerType
      });
    }
    log("body is $body");
    try {
      final response = await http.post(
        Uri.parse(ApiRoutes.register),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        // log("response is $responseData");
        return RegistrationResponse.fromJson(responseData);
      } else {
        final errorData = json.decode(response.body);
        log('Error: ${errorData['msg']}');
        return RegistrationResponse(
          status: false,
          msg: errorData['msg'],
        );
      }
    } catch (e) {
      log('Error: $e');
      return RegistrationResponse(
        status: false,
        msg: e.toString(),
      );
    }
  }

  Future<GetUserDetailsResponse?> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? currentUserToken = prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse(ApiRoutes.getUserDetails),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $currentUserToken',
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return GetUserDetailsResponse.fromJson(responseData);
      } else {
        final errorData = json.decode(response.body);
        log('Error: ${errorData['msg']}');
        return null;
      }
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }
}
