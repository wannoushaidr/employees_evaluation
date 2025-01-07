
import 'package:clothes_store/models/user.dart';
import 'package:clothes_store/services/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as Dio;

class Auth extends ChangeNotifier{
  bool _isLoggedIn=false;
  late User _user;
  late String _token;

  bool get authenticated => _isLoggedIn;
  User get user => _user;

  void login({required Map creds}) async{
    // print(creds);
    // print("login step one");

        
      try {  
            Dio.Response response = await dio(additionalHeaders: {}).post('/sanctum/token',data:creds);

            print(response.data.toString());
            print('Response data: ${response.data}'); // Print complete response data 
                    this._isLoggedIn = true;

            String token = response.data.toString();
                    notifyListeners();

            // this.tryToken(token: token);  

    
    } catch (e) {  
          print("Login failed: $e");  }
  }  

  void tryToken({required String token})async{
    if(token == null){
      return ;
    }else{
      try{
        Dio.Response response = await dio(additionalHeaders: {}).get('/user',
        options: Dio.Options(headers:{'Authorization':'Bearer $token'})) ;

        this._isLoggedIn = true;
        this._user = User.formJson(response.data);
        notifyListeners();
        print(_user);
     
      }catch(e){
        print("failur $e");
      }

    }

  }

  void logout(){
    _isLoggedIn = false;
    notifyListeners();
  }


}



