
import 'package:clothes_store/services/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as Dio;

class Auth extends ChangeNotifier{
  bool _isLoggedIn=false;

  bool get authenticated => _isLoggedIn;

  void login({required Map creds}) async{
    print(creds);
    print("login step one");
    Map<String, String> additionalHeaders = {  
      // Add your multiple keys here, e.g.:  
      // 'Custom-Header-1': 'Value1',  
      // 'Custom-Header-2': 'Value2',  
      // Add as many headers as needed  
    };  
    
  try {  
    Dio.Response response = await createDio(additionalHeaders: {}).post('/login', data: creds);  
    print('Response data: ${response.data}'); // Print complete response data  


    if (response.statusCode == 200) {  
      print("Good login");  

      // Assuming the token is in the response  
      String token = response.data['token'];  // Adjust based on your actual response structure  

      // Optionally save the token using secure storage  
      // Use a secure storage method to save the token  
      // final storage = new FlutterSecureStorage();  
      // await storage.write(key: 'jwt', value: token);  

      // Set the token in Dio's headers for future requests  
      createDio(additionalHeaders: {}).options.headers['Authorization'] = 'Bearer $token'; // This is how you typically set the JWT token  

      _isLoggedIn = true; // Update login status  
      notifyListeners();  
    } else {  
      print("Failed to login: ${response.statusCode}, ${response.data}");  
    }  
  } catch (e) {  
    print("Login failed: $e");  }
  }  

  void logout(){
    _isLoggedIn = false;
    notifyListeners();
  }


}