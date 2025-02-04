import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class Auth extends ChangeNotifier {
  late String _token;
  late var _user = UserModel( name: "samer", 
  email: "no3umms@gmmail.com",  role: "customer_service",id:11,image:"");

  bool authenticated = true;
  UserModel get user => _user;

  Future<String?> login ({required Map creds, required BuildContext context})async{
    try{
    http.Response response =await http.post(Uri.parse('http://127.0.0.1:8000/api/sanctum/token'),body: creds);
   // print(response.body);
       List<String> lines = response.body.split('\n');
        String responseBody = lines.skip(2).join('\n');
       // print(responseBody);
print(responseBody);
        return responseBody;
    }
    catch(e)
    {
      print(e);
    }
  }

  Future<Map<String,dynamic>?> tryToken({required String token})async{
    try{
    http.Response response = await http.get(Uri.parse('http://127.0.0.1:8000/api/user'),headers: {'Authorization':'Bearer $token'});
     List<String> lines = response.body.split('\n');
    String responseBody = lines.skip(2).join('\n');
    Map<String,dynamic>? data = jsonDecode(responseBody);
    authenticated = true;
               notifyListeners();
               print(data);
  return data;
  }catch(e)
  {
    print(e);
  }
  }
    void logout(){
    authenticated = false;
    notifyListeners();
  }

}