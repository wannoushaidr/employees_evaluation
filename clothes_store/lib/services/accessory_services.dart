import 'dart:convert';
// import 'dart:html' as html;
import 'dart:typed_data';
import 'package:clothes_store/models/accessory_model.dart';

import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

class AppAccessoriesService {
  Future<List<AccessoryModel?>?> GetAllAccessories() async {
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/accesories/get_all_accesories";
      http.Response response = await http.get(Uri.parse(url));
      List<String> lines = response.body.split('\n');
      String responseBody = lines.skip(2).join('\n');
      Map<String, dynamic> data = jsonDecode(responseBody);
      List<dynamic> jsonData = data['data'];
      List<AccessoryModel> accessories = [];
      for (var data in jsonData) {
        AccessoryModel accessory = AccessoryModel.fromJson(data);
        accessories.add(accessory);
      }

      return accessories;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool?> AddNewAccessory({
    required String type,
    required Uint8List image,
    required String SelectedFile,
    required String branch_id,
  }) async {
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/accesories/set_new_accesories";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['type'] = type;
      request.fields['branch_id'] = branch_id;

      request.files.add(http.MultipartFile.fromBytes(
        'image', // The field name expected by the server
        image,
        filename: SelectedFile,
      ));

      //  print(image);
      var response = await request.send();
      // http.Response response = await http.post(Uri.parse(url),
      //     body: {'type': type, 'image': image, 'branch_id': branch_id});
      print(response.statusCode);
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
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

  // Future<bool?> UpdateAccessory({
  //   required String id,
  //   required String type,
  //     required Uint8List image,
  //   // Uint8List? image,
  //   String? SelectedFile,
  //   required String branch_id,
  // }) async {
  //   try {
  //     String url =
  //         "http://127.0.0.1:8000/api/admin/accesories/update_accesories";

  //     var request = http.MultipartRequest('PUT', Uri.parse(url));
  //     request.fields['type'] = type;
  //     request.fields['branch_id'] = branch_id;
  //     request.files.add(http.MultipartFile.fromBytes(
  //       'image', // The field name expected by the server
  //       image,
  //       filename: SelectedFile,
  //     ));

  //     // if (image != null && SelectedFile != null) {
  //     //   request.files.add(http.MultipartFile.fromBytes(
  //     //     'image', // The field name expected by the server
  //     //     image,
  //     //     filename: SelectedFile,
  //     //   ));
  //     // }
  //     //  print(image);
  //     var response = await request.send();
  //     // http.Response response = await http.post(Uri.parse(url),
  //     //     body: {'type': type, 'image': image, 'branch_id': branch_id});

  //     print("ssssssssssss");
  //     // print(response.stream);
  //           print("ssssssssssss");

  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
List<String>? message;
  Future<bool?> UpdateAccessory({
    required String id,
    required String type,
    required Uint8List image,
    String? SelectedFile,
    required String branch_id,
  }) async {
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/accesories/update_accesories";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['id'] = id;
      request.fields['type'] = type;
      request.fields['branch_id'] = branch_id;

      request.files.add(http.MultipartFile.fromBytes(
        'image', // The field name expected by the server
        image,
        filename: SelectedFile,
      ));
      print(request);
      //  print(image);
      var response = await request.send();
      // http.Response response = await http.post(Uri.parse(url),
      //     body: {'type': type, 'image': image, 'branch_id': branch_id});
      print(response.statusCode);
      String responseBody = await response.stream.bytesToString();
      print(responseBody);
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

    //   var request = http.MultipartRequest('POST', Uri.parse(url));
    //   request.fields['id'] = id;
    //   request.fields['type'] = type;
    //   request.fields['branch_id'] = branch_id;
    //   request.files.add(http.MultipartFile.fromBytes(
    //     'image', // The field name expected by the server
    //     image,
    //     filename: SelectedFile ?? 'image.jpg', // Provide default name if null
    //   ));
    //   print(id);
    //   print(request);

    //   var response = await request.send();

    //   // Read the response stream and convert to String
    //   final responseBytes = await response.stream.toBytes();
    //   final responseString = String.fromCharCodes(responseBytes);

    //   print("Response content: $responseString");

    //   if (response.statusCode == 200) {
    //     return true;
    //   } else {
    //     print("Error: ${response.statusCode}");
    //     return false;
    //   }
    // } catch (e) {
    //   print("Exception: $e");
    //   return null;
    // }
  }

  Future<bool?> DeleteAccessory({
    required String id,
  }) async {
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/accesories/delete_accesories";
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
}
