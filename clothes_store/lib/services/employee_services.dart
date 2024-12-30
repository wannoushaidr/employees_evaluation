import 'dart:convert';
import 'dart:typed_data';

import 'package:clothes_store/models/employee_model.dart';

import 'package:http/http.dart' as http;

class AppEmployeesService {
  Future<List<EmployeeModel?>?> GetAllEmployees() async {
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/employees/get_all_employees";
      http.Response response = await http.get(Uri.parse(url));
      List<String> lines = response.body.split('\n');
      String responseBody = lines.skip(2).join('\n');
      Map<String, dynamic> jsonData = jsonDecode(responseBody);
      List<EmployeeModel> employees = [];
      for (var data in jsonData['data']) {
        EmployeeModel employee = EmployeeModel.fromJson(data);
        employees.add(employee);
      }

      return employees;
    } catch (e) {
      print(e);
    }
  }

  Future<bool?> AddNewEmployee(
      {required String name,
      required String number,
      required String description,
      required String gender,
      required String position,
      required String branch_id,
      String? leader_id,
      required Uint8List image,
      required String SelectedFile}) async {
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/employees/set_new_employees";
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
      request.fields['number'] = number;
      request.fields['description'] = description;
      request.fields['gender'] = gender;
      request.fields['position'] = position;
      request.fields['branch_id'] = branch_id;
      if (leader_id != null) {
        request.fields['leader_id'] = leader_id;
      }

      request.files.add(http.MultipartFile.fromBytes(
        'image', // The field name expected by the server
        image,
        filename: SelectedFile,
      ));

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
  }

  Future<bool?> UpdateEmployee(
      {required String id,
      required String name,
      required String number,
      required String description,
      required String gender,
      required String position,
      required String branch_id,
      String? leader_id,
      Uint8List? image,
      String? SelectedFile}) async {
    try {
      String url = "http://127.0.0.1:8000/api/admin/employees/update_employees";
      // http.Response response = await http.put(Uri.parse(url), body: {
      //   'id': id,
      //   'name': name,
      //   'number': number,
      //   'description': description,
      //   'gender': gender,
      //   'position': position,
      //   'branch_id': branch_id,
      //   'leader_id': leader_id,
      //   'image': image,
      // });

      var request = http.MultipartRequest('PUT', Uri.parse(url));
      request.fields['id'] = id;
      request.fields['name'] = name;
      request.fields['number'] = number;
      request.fields['description'] = description;
      request.fields['gender'] = gender;
      request.fields['position'] = position;
      request.fields['branch_id'] = branch_id;
      if (leader_id != null) {
        request.fields['leader_id'] = leader_id;
      }

      if (image != null && SelectedFile != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image', // The field name expected by the server
          image,
          filename: SelectedFile,
        ));
      }

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
  }

  Future<bool?> DeleteEmployee({
    required String id,
  }) async {
    try {
      String url = "http://127.0.0.1:8000/api/admin/employees/delete_employees";
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
