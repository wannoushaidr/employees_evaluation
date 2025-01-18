
import 'package:clothes_store/models/user.dart';
import 'package:clothes_store/services/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as Dio;

class Auth extends ChangeNotifier{  
  bool _isLoggedIn=true;
  late String _token;
  late var _user = User( name: "haidar wannous", 
  email: "wannous.email@example.com",  role: "admin",id:8);

  bool get authenticated => _isLoggedIn;
  User get user => _user;


  void login({required Map creds, required BuildContext context}) async{
    // print(creds);
    // print("login step one");

        
      try {  
        print("step one");
            Dio.Response response = await dio(additionalHeaders: {}).post('/sanctum/token',data:creds);
            print("step two");
            print(response.data.toString());
            print('Response data: ${response.data}'); // Print complete response data 

            String token = response.data.toString();
            print("step three");
            _isLoggedIn = true;

            // this.tryToken(token: token);  
              print("step 4");
            // this._isLoggedIn = true;
              notifyListeners();
              print("ten 10");
    
    } catch (e) {  
          print("step 5");
          print("Login failed: $e");  }
  }  


    void tryToken({required String token})async{
      if(token == null){
        return ;
      }
      else{
            try{
              Dio.Response response = await dio(additionalHeaders: {}).get('/user',
              options: Dio.Options(headers:{'Authorization' : 'Bearer $token'})) ;

              this._isLoggedIn = true;
              this._user = User.fromJson(response.data);
              notifyListeners();
              print(_user);
          
            }catch(e){
              print(e);
            }

      }

    }



  void logout(){
    _isLoggedIn = false;
    notifyListeners();
  }


}
