
import 'dart:convert';

import 'package:clothes_store/models/point_model.dart';

import 'package:http/http.dart' as http;

class AppPointsService {
  Future<List<PointModel?>?> GetAllPoint() async {
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/points/get_all_points";
      http.Response response = await http.get(Uri.parse(url));
      //  print(response.body);
      List<String> lines = response.body.split('\n');
      String responseBody = lines.skip(2).join('\n');
      print(responseBody);
      Map<String, dynamic> data = jsonDecode(responseBody);

      List<dynamic> jsonData = data['data'];
      List<PointModel> points = [];
      for (var data in jsonData) {
        PointModel point = PointModel.fromJson(data);
        points.add(point);
      }

      return points;
    } catch (e) {
      print(e);
    }
  }


  // Future<bool?> AddNewCompany(
  //     {required String name,
  //     required String number,
  //     // required String number_of_branches,
  //     required String email,
  //     required String address}) async {
  //   try {
  //     String url =
  //         "http://127.0.0.1:8000/api/admin/companies/set_new_companies";
  //     http.Response response = await http.post(Uri.parse(url), body: {
  //       'name': name,
  //       'number': number,
  //       // 'number_of_branches': number_of_branches,
  //       'email': email,
  //       'address': address
  //     });
  //     print(response.statusCode);
  //     print(response.body);

  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }



  // Future<bool?> UpdateCompany({
  //   required String id,
  //   required String name,
  //   required String number,
  //   required String address,
  //   // required String number_of_branches,
  //   required String email,
  // }) async {
  //   try {
  //     String url = "http://127.0.0.1:8000/api/admin/companies/update_companies";
  //     http.Response response = await http.put(Uri.parse(url), body: {
  //       'id': id,
  //       'name': name,
  //       'number': number,
  //       'address': address,
  //       'email': email,
  //       // 'number_of_branches': number_of_branches,
  //     });

  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<bool?> DeletePoint({
    required String id,
  }) async {
    try {
      String url = "http://127.0.0.1:8000/api/admin/points/delete_points";
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

  getBranchesCount() {}
}
