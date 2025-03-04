import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class Auth extends ChangeNotifier {
  late String _token;
  UserModel user = UserModel(
      name: "admin",
      email: "admin@gmail.com",
      role: "admin",
      id: 7,
      image: "assets/images/1740687459_image.jpg");

  bool authenticated = true;
  //UserModel get user => _user;
// UserModel user;
  Future<String?> login(
      {required Map creds, required BuildContext context}) async {
    try {
      http.Response response = await http.post(
          Uri.parse('http://127.0.0.1:8000/api/sanctum/token'),
          body: creds);
      // print(response.body);
      List<String> lines = response.body.split('\n');
      String responseBody = lines.skip(2).join('\n');
      // print(responseBody);
      print(responseBody);
      return responseBody;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<Map<String, dynamic>?> tryToken({required String token}) async {
    try {
      http.Response response = await http.get(
          Uri.parse('http://127.0.0.1:8000/api/user'),
          headers: {'Authorization': 'Bearer $token'});
      List<String> lines = response.body.split('\n');
      String responseBody = lines.skip(2).join('\n');
      Map<String, dynamic>? data = jsonDecode(responseBody);
      authenticated = true;
      notifyListeners();
      print(data);
      return data;
    } catch (e) {
      print(e);
    }
    return null;
  }

  void logout() {
    authenticated = false;
    notifyListeners();
  }
}
