import 'dart:convert';
import 'dart:typed_data';

import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/models/user.dart';

import 'package:http/http.dart' as http;



import 'dart:convert';
import 'package:http/http.dart' as http;



class AppUsersService {


  Future<List<UserModel?>?> GetAllUsers() async {
    try {
      String url = "http://127.0.0.1:8000/api/admin/users/get_all_users";
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Split response body into lines and skip the first two lines
        List<String> lines = response.body.split('\n');
        String responseBody = lines.skip(2).join('\n');
        print(responseBody);

        // Decode the adjusted response body
        List<dynamic> jsonData = jsonDecode(responseBody);
                print(jsonData);
        List<UserModel> employees = jsonData.map((data) {
          return UserModel.fromJson(data);
        }).toList();

        return employees;
      } else {
        print("Error: ${response.statusCode}");
        print(response.body); // Print the response body for debugging
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }


  Future<bool?> SetNewAdmin(
      {
        required String name,
      // required String number,
      // required String gender,
      required String role,
      // required Uint8List image,
      // required String SelectedFile, 
       required String email,
       required String password,
      Uint8List? image,  
  String? selectedFile,  
      }) async {
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/users/set_new_admins";
      // http.Response response = await http.post(Uri.parse(url), body: {
      //   'name': name,
      //   'number': number,
      //   'description': description,
      //   'gender': gender,
      //   'position': position,
      //   'branch_id': branch_id,
      //   'leader_id': leader_id,
      //   'image': image,
      // });

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['name'] = name;
      // request.fields['number'] = number;
      // request.fields['gender'] = gender;
      request.fields['role'] = role;
      request.fields['email'] = email;
      request.fields['password'] = password;
      
// if (image != null && selectedFile != null) {  
//       request.files.add(http.MultipartFile.fromBytes(  
//         'image', // The field name expected by the server  
//         image,  
//         filename: selectedFile,  
//       ));  
//     }  
      

      var response = await request.send();
      print(response.statusCode);
      String responseBody = await response.stream.bytesToString();
      print('Response Body: $responseBody');
      if (response.statusCode == 200) {
        return true;
      } else { 
Map<String, dynamic> data = jsonDecode(responseBody);
Map<String, dynamic> data2 = data['errors'];
List<String> errors = [];

data2.forEach((key, value) {  
  if (value is List) {
    // Iterate through each item in the list
    for (var error in value) {
      errors.add(error.toString());
    }
  }
});

message = errors;
        return false;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

List<String>? message;

  Future<bool?> UpdateAdmin({
    required String id,  
   required String name,
      // required String number,
      // required String gender,
      required String role,
      // required Uint8List image,
      // required String SelectedFile, 
      required String email,}) async {
    try {
      String url = "http://127.0.0.1:8000/api/admin/users/update_admins";
      http.Response response = await http.put(Uri.parse(url), body: {
        'id': id,
        'name': name,
        'role': role,
        'email': email,
        
      });

      if (response.statusCode == 200) {
        return true;
      } else {
         List<String> lines = response.body.split('\n');
String responseBody = lines.skip(2).join('\n');
Map<String, dynamic> data = jsonDecode(responseBody);
Map<String, dynamic> data2 = data['errors'];
List<String> errors = [];

data2.forEach((key, value) {  
  if (value is List) {
    // Iterate through each item in the list
    for (var error in value) {
      errors.add(error.toString());
    }
  }
});

message = errors;
        return false;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }




  Future<bool?> DeleteAdmin({
    required String id,
  }) async {
    try {
      String url = "http://127.0.0.1:8000/api/admin/users/delete_admins";
      http.Response response = await http.delete(Uri.parse(url), body: {
        'id': id,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }



  Future<bool?> updatePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      String url = "http://127.0.0.1:8000/api/password/reset"; // Replace with your actual API endpoint
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['email'] = email;
      // request.fields['number'] = number;
      // request.fields['gender'] = gender;
      request.fields['old_password'] = oldPassword;
      request.fields['new_password'] = newPassword;
      request.fields['new_password_confirmation'] = newPasswordConfirmation;
      print("sssssssssssssss1");
      // http.Response response = await http.put(Uri.parse(url), body: {
        
      //   'email': email,
      //   'old_password': oldPassword,
      //   'new_password': newPassword,
      //   'new_password_confirmation': newPasswordConfirmation,
      var response = await request.send();
      print(response.statusCode);
      String responseBody = await response.stream.bytesToString();
      print('Response Body: $responseBody');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return null;
}}