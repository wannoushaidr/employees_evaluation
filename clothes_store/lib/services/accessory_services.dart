import 'dart:convert';
import 'dart:html' as html;
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

      
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool?> UpdateAccessory({
    required String id,
    required String type,
    Uint8List? image,
    String? SelectedFile,
    required String branch_id,
  }) async {
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/accesories/update_accesories";

      var request = http.MultipartRequest('PUT', Uri.parse(url));
      request.fields['type'] = type;
      request.fields['branch_id'] = branch_id;

      if (image != null && SelectedFile != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image', // The field name expected by the server
          image,
          filename: SelectedFile,
        ));
      }
      //  print(image);
      var response = await request.send();
      // http.Response response = await http.post(Uri.parse(url),
      //     body: {'type': type, 'image': image, 'branch_id': branch_id});

      print(response.stream);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
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
  }
}
