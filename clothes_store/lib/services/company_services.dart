import 'dart:convert';

import 'package:clothes_store/models/company_model.dart';

import 'package:http/http.dart' as http;

class AppCompaniesService {
  Future<List<CompanyModel?>?> GetAllCompanies() async {
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/companies/get_all_companies";
      http.Response response = await http.get(Uri.parse(url));
      //  print(response.body);
      List<String> lines = response.body.split('\n');
      String responseBody = lines.skip(2).join('\n');
      print(responseBody);
      Map<String, dynamic> data = jsonDecode(responseBody);

      List<dynamic> jsonData = data['data'];
      List<CompanyModel> companies = [];
      for (var data in jsonData) {
        CompanyModel company = CompanyModel.fromJson(data);
        companies.add(company);
      }

      return companies;
    } catch (e) {
      print(e);
    }
    return null;
  }
List<String>? message;
  Future<bool?> AddNewCompany(
      {required String name,
      required String number,
      // required String number_of_branches,
      required String email,
      required String address}) async {
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/companies/set_new_companies";
      http.Response response = await http.post(Uri.parse(url), body: {
        'name': name,
        'number': number,
        // 'number_of_branches': number_of_branches,
        'email': email,
        'address': address
      });
      print(response.statusCode);
      print(response.body);

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

  Future<bool?> UpdateCompany({
    required String id,
    required String name,
    required String number,
    required String address,
    // required String number_of_branches,
    required String email,
  }) async {
    try {
      String url = "http://127.0.0.1:8000/api/admin/companies/update_companies";
      http.Response response = await http.put(Uri.parse(url), body: {
        'id': id,
        'name': name,
        'number': number,
        'address': address,
        'email': email,
        // 'number_of_branches': number_of_branches,
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

  Future<bool?> DeleteCompany({
    required String id,
  }) async {
    try {
      String url = "http://127.0.0.1:8000/api/admin/companies/delete_companies";
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
