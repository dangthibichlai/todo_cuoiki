import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_cuoiky/resources/end-point.dart';

class AuthService {
  //  gọi api login
  Future login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(EndPoint.login),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'password': password, 'fcm_token': []}),
      );
      return response;
    } catch (e) {
      return e;
    }
  }

  Future<http.Response> sendOtp(String email) async {
    const url = EndPoint.send_otp;

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${null}',
      },
      body: jsonEncode({'email': email}),
    );
    return response;
  }

  Future<http.Response> verifyOtp(String email, String otp) async {
    const url = EndPoint.verify_otp;

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${null}',
      },
      body: jsonEncode({'email': email, 'otp': otp}),
    );
    return response;
  }
  // sign up
  Future<http.Response> register(String email, String password, String name) async {
    const url = EndPoint.register;

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password, 'full_name': name}),
    );
    return response;
  }
}
