import 'dart:convert';
import 'dart:typed_data';

import 'package:clothes_store/models/employee_model.dart';

import 'package:http/http.dart' as http;

// class AppEmployeesService {
//   Future<List<EmployeeModel?>?> GetAllEmployees() async {
//     try {
//       String url =
//           "http://127.0.0.1:8000/api/admin/employees/get_all_employees";
//       http.Response response = await http.get(Uri.parse(url));
//       List<String> lines = response.body.split('\n');
//       String responseBody = lines.skip(2).join('\n');
//       Map<String, dynamic> jsonData = jsonDecode(responseBody);
//       print(jsonData);
//       List<EmployeeModel> employees = [];
//       for (var data in jsonData['data']) {
//         EmployeeModel employee = EmployeeModel.fromJson(data);
//         employees.add(employee);
//       }

//       return employees;
//     } catch (e) {
//       print(e);
//     }
//   }

import 'dart:convert';
import 'package:http/http.dart' as http;

class AppEmployeesService {


  Future<List<EmployeeModel?>?> GetAllEmployees() async {
    try {
      String url = "http://127.0.0.1:8000/api/admin/employees/get_all_employees";
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Split response body into lines and skip the first two lines
        List<String> lines = response.body.split('\n');
        String responseBody = lines.skip(2).join('\n');

        // Decode the adjusted response body
        List<dynamic> jsonData = jsonDecode(responseBody);
        List<EmployeeModel> employees = jsonData.map((data) {
          return EmployeeModel.fromJson(data);
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


  Future<bool?> AddNewEmployee(
      {required String name,
      required String number,
      required String description,
      required String gender,
      required String active,
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
      request.fields['active'] = active;
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
      required String active,
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
      //     'active'= active,
      //   'branch_id': branch_id,
      //   'leader_id': leader_id,
      //   'image': image,
      // });

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['id'] = id;
      request.fields['name'] = name;
      request.fields['number'] = number;
      request.fields['description'] = description;
      request.fields['active'] = active;
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

Future<Map<String, int>?> getEmployeesCount() async {
  try {
    String url = "http://127.0.0.1:8000/api/admin/employees/get_employees_count";
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Print the entire response body for debugging
      print("Response body: ${response.body}");

      // Split response body into lines and skip the first two lines
      List<String> lines = response.body.split('\n');
      String responseBody = lines.skip(2).join('\n');

      // Decode the adjusted response body
      Map<String, dynamic> data = jsonDecode(responseBody);

      // Extract counts and return as a map
      Map<String, int> counts = {
        'employee_count': data['employee_count'],
        'customer_service_count': data['customer_service_count'],
        'manager_count': data['manager_count'],
        'supervisor_count': data['supervisor_count']
      };
      return counts;
    } else {
      print("Error: ${response.statusCode}");
      print(response.body); // Print the response body for debugging
      return null;
    }
  } catch (e) {
    print("Exception: $e");
    return null;
  }
}


// for manager
Future<Map<String, int>?> getSupervisorsAndCustomerServiceEmployees(int id) async {
  try {
    String url = "http://127.0.0.1:8000/api/employees/getSupervisorsAndCustomerServiceEmployees/$id";
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Print the entire response body for debugging
      // print("Response body: ${response.body}");
      print("response");
      print(response);

      // Split response body into lines and skip the first two lines
      List<String> lines = response.body.split('\n');
      String responseBody = lines.skip(2).join('\n');
            print(responseBody);


      // Decode the adjusted response body
      Map<String, dynamic> data = jsonDecode(responseBody);
      print("data is");
      print(data);

      // Extract counts and return as a map
      Map<String, int> counts = {
        'employee_count': data['employee_count'],
        'customer_service_count': data['customer_service_count'],
        'supervisor_count': data['supervisor_count']
      };
      return counts;
    } else {
      print("Error: ${response.statusCode}");
      print(response.body); // Print the response body for debugging
      return null;
    }
  } catch (e) {
    print("Exception: $e");
    return null;
  }
}

// for supervisior
Future<Map<String, int>?> getCustomerServiceEmployeesCount(int id) async {
  try {
    String url = "http://127.0.0.1:8000/api/employees/getCustomerServiceEmployeesCount/$id";
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Print the entire response body for debugging
      // print("Response body: ${response.body}");
      print("response");
      print(response);

      // Split response body into lines and skip the first two lines
      List<String> lines = response.body.split('\n');
      String responseBody = lines.skip(2).join('\n');
            print(responseBody);


      // Decode the adjusted response body
      Map<String, dynamic> data = jsonDecode(responseBody);
      print("data is");
      print(data);

      // Extract counts and return as a map
      Map<String, int> counts = {
        'employee_count': data['employee_count'],
        'customer_service_count': data['customer_service_count'],
      };
      return counts;
    } else {
      print("Error: ${response.statusCode}");
      print(response.body); // Print the response body for debugging
      return null;
    }
  } catch (e) {
    print("Exception: $e");
    return null;
  }
}



  Future<List<EmployeeModel?>?> GetMyEmployeesEnformation(int id) async {
    try {
      String url = "http://127.0.0.1:8000/api/employees/get_my_employees_information/$id";
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Split response body into lines and skip the first two lines
        List<String> lines = response.body.split('\n');
        String responseBody = lines.skip(2).join('\n');
        print("**********************111111111111*************************");
        // Decode the adjusted response body
        List<dynamic> jsonData = jsonDecode(responseBody);
        print("*********************2222222222222***************************");
        List<EmployeeModel> employees = jsonData.map((data) {
          print("********************33333333333333****************************");
          return EmployeeModel.fromJson(data);
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


  Future<List<EmployeeModel?>?> get_my_information(int id) async {
    try {
      String url = "http://127.0.0.1:8000/api/employees/get_my_information/$id";
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Split response body into lines and skip the first two lines
        List<String> lines = response.body.split('\n');
        String responseBody = lines.skip(2).join('\n');
        print("**********************111111111111*************************");
        // Decode the adjusted response body
        List<dynamic> jsonData = jsonDecode(responseBody);
        print("*********************2222222222222***************************");
        List<EmployeeModel> employees = jsonData.map((data) {
          print("********************33333333333333****************************");
          return EmployeeModel.fromJson(data);
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




}
