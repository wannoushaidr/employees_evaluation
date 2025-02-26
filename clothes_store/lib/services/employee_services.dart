import 'dart:convert';
import 'dart:typed_data';

import 'package:clothes_store/models/employee_model.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:http/http.dart' as http;

class AppEmployeesService {

List<String>? message;
 
  Future<List<EmployeeModel?>?> GetAllEmployees() async {
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/employees/get_all_employees";
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
      //required int user_id,
      String? leader_id,
      required Uint8List image,
      required String SelectedFile,
      required String email}) async {
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
      // request.fields['user_id'] = user_id;
      request.fields['email'] = email;  
      if (leader_id != null) {
        request.fields['leader_id'] = leader_id;
      }

      request.files.add(http.MultipartFile.fromBytes(
        'image', // The field name expected by the server
        image,
        filename: SelectedFile,
      ));

      var response = await request.send();
      // print(response.statusCode);
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

  Future<bool?> UpdateEmployee(
      {required String id,
      required String name,
      required String number,
      required String description,
      required String gender,
      required String active,
      required String position,
      required String branch_id,
      String? user_id,
      String? leader_id,
      Uint8List? image,
      String? SelectedFile,
      required String email}) async {
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/employees/update_employees"; // Include ID in URL

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['id'] = id;
      request.fields['name'] = name;
      request.fields['number'] = number;
      request.fields['description'] = description;
      request.fields['active'] = active;
      request.fields['gender'] = gender;
      request.fields['position'] = position;
      request.fields['branch_id'] = branch_id;
      request.fields['user_id'] = user_id.toString();
      request.fields['email'] = email;
      if (leader_id != null) {
        request.fields['leader_id'] = leader_id;
      }
      if (image != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image',
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

    //   // Populate fields for the employee update request
    //   request.fields['id'] = id;
    //   request.fields['name'] = name;
    //   request.fields['number'] = number;
    //   request.fields['description'] = description;
    //   request.fields['active'] = active;
    //   request.fields['gender'] = gender;
    //   request.fields['position'] = position;
    //   request.fields['branch_id'] = branch_id;
    //   request.fields['email'] = email; // Include email in the request
    //   request.fields['user_id'] = user_id; // Include user ID in the request

    //   // Optional fields
    //   if (leader_id != null) {
    //     request.fields['leader_id'] = leader_id;
    //   }

    //   // Attach image if provided
    //   if (image != null && selectedFile != null) {
    //     request.files.add(http.MultipartFile.fromBytes(
    //       'image', // The field name expected by the server
    //       image,
    //       filename: selectedFile,
    //     ));
    //   }

    //   print("Request is:");
    //   // print(request);

    //   var response = await request.send();
    //   // print(response.statusCode);
    //   String responseBody = await response.stream.bytesToString();
    //   // print('Response Body: $responseBody');

    //   if (response.statusCode == 200) {
    //     return true;
    //   } else {
    //     print('Error updating employee: $responseBody');
    //     return false;
    //   }
    // } catch (e) {
    //   print(e);
    //   return false; // Return false if there's an error
    // }
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
    return null;
  }

  Future<Map<String, int>?> getEmployeesCount() async {
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/employees/get_employees_count";
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
  Future<Map<String, int>?> getSupervisorsAndCustomerServiceEmployees(
      int id) async {
    try {
      String url =
          "http://127.0.0.1:8000/api/employees/getSupervisorsAndCustomerServiceEmployees/$id";
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
      String url =
          "http://127.0.0.1:8000/api/employees/getCustomerServiceEmployeesCount/$id";
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
          'total_points': data['total_points'],
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

  Future<List<EmployeeModel?>?> GetMyAtivateEmployee(int id) async {
    try {
      String url =
          "http://127.0.0.1:8000/api/employees/get_my_activativate_employee/$id";
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Split response body into lines and skip the first two lines
        List<String> lines = response.body.split('\n');
        String responseBody = lines.skip(2).join('\n');
        print("**********************111111111111*************************");
        // Decode the adjusted response body
        List<dynamic> jsonData = jsonDecode(responseBody);
        print("*********************2222222222222***************************");
        print(jsonData);
        List<EmployeeModel> employees = jsonData.map((data) {
          print(
              "********************33333333333333****************************");
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

  Future<List<EmployeeModel?>?> GetMyEmployeesEnformation(int id) async {
    try {
      String url =
          "http://127.0.0.1:8000/api/employees/get_my_employees_information/$id";
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Split response body into lines and skip the first two lines
        List<String> lines = response.body.split('\n');
        String responseBody = lines.skip(2).join('\n');
        print("**********************111111111111*************************");
        // Decode the adjusted response body
        List<dynamic> jsonData = jsonDecode(responseBody);
        print("*********************2222222222222***************************");
        // print(jsonData);
        List<EmployeeModel> employees = jsonData.map((data) {
          print(
              "********************33333333333333****************************");
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
          print(
              "********************33333333333333****************************");
          print("jsonData");
          print(jsonData);

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

// Future<Map<String, int>?> getStatistic(int id) async {  
//     try {  
//         // Update the URL to your correct endpoint  
//         String url = "http://127.0.0.1:8000/api/employee/get_statistic/$id"; // Use your local IP address  
//         http.Response response = await http.get(Uri.parse(url));  

//         // Log the status code  
//         print("Response status code: ${response.statusCode}");  

//         if (response.statusCode == 200) {  
//             // Print the raw response for debugging  
//             print("Response body: ${response.body}");  
//             print("******");

//             // Decode the JSON response  
//             List<dynamic> responseData = jsonDecode(response.body);  
//             print("8888888");
//             if (responseData.isNotEmpty) {  
//                 // Extract counts and return as a map  
//                 Map<String, int> employees = {  
//                     'employee_count': responseData[0]['employee_count'],  
//                     'points_sum': responseData[0]['points_sum'],  
//                     // Assuming evaluation is an integer, handle accordingly  
//                     'evaluation': responseData[0]['evaluation'] == "good" ? 1 : 0 // Convert evaluation to an integer if needed  
//                 };  
//                 return employees;  
//             } else {  
//                 return null; // Handle empty response appropriately  
//             }   
//         } else {  
//             // Log the error response body for further diagnostics  
//             print("Error: ${response.statusCode}, Body: ${response.body}");  
//             return null;  
//         }  
//     } catch (e) {  
//         print("Exception: $e");  
//         return null;  
//     }  
// }


Future<Map<String, int>?> getStatistic(int id) async {  
    try {  
        String url = "http://127.0.0.1:8000/api/employee/get_statistic/$id"; // Your local IP address  
        http.Response response = await http.get(Uri.parse(url));  

        // Log the status code  
        print("Response status code: ${response.statusCode}");  

        if (response.statusCode == 200) {  
            // Print the raw response for debugging  
            print("Response body: ${response.body}");  

            // Clean up the response by removing unwanted HTML or comments  
            String cleanedResponse = response.body;  

            // Regular expression to remove HTML comments  
            cleanedResponse = cleanedResponse.replaceAll(RegExp(r'<!--.*?-->', dotAll: true), '').trim();  

            // Now check if cleaned response is valid JSON  
            print("Cleaned response: $cleanedResponse");  

            if (cleanedResponse.isNotEmpty) {  
                // Decode the JSON response  
                Map<String, dynamic> responseData = jsonDecode(cleanedResponse);  

                // Extract counts and return as a map  
                Map<String, int> counts = {  
                    'employee_count': responseData['employee_count'],  
                    'points_sum': int.parse(responseData['points_sum']), // Convert points_sum to integer  
                    'evaluation': (responseData['evaluation'] == "good") ? 1 : 0 // Convert evaluation to an integer  
                };  

                return counts;  
            }  
        } else {  
            print("Error: ${response.statusCode}, Body: ${response.body}");  
            return null; // Handle error appropriately  
        }  
    } catch (e) {  
        print("Exception: $e");  
        return null; // Handle exception appropriately  
    }
    return null;  
}

}
