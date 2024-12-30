import 'dart:convert';

import '../models/branch_model.dart';
import 'package:http/http.dart' as http;

class AppBranchesService {
  Future<List<BranchModel>?> GetAllBranches() async {
    try {
      String url = "http://127.0.0.1:8000/api/admin/branches/get_all_branches";
      http.Response response = await http.get(Uri.parse(url));
      List<String> lines = response.body.split('\n');
      String responseBody = lines.skip(2).join('\n');
      Map<String, dynamic> data = jsonDecode(responseBody);
      List<dynamic> jsonData = data['data'];
      List<BranchModel> branches = [];
      for (var data in jsonData) {
        BranchModel branch = BranchModel.fromJson(data);
        branches.add(branch);
      }

      return branches;
    } catch (e) {
      print(e);
    }
  }

  Future<bool?> AddNewBranch(
      {required String name,
      required String phone,
      required String address,
      required String email,
      required String company_id}) async {
    try {
      String url = "http://127.0.0.1:8000/api/admin/branches/set_new_branches";
      http.Response response = await http.post(Uri.parse(url), body: {
        'name': name,
        'phone': phone,
        'address': address,
        'email': email,
        'company_id': company_id,
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

  Future<bool?> UpdateBranch(
      {required String id,
      required String name,
      required String phone,
      required String address,
      required String email,
      required String company_id}) async {
    try {
      String url = "http://127.0.0.1:8000/api/admin/branches/update_branches";
      http.Response response = await http.put(Uri.parse(url), body: {
        'id': id,
        'name': name,
        'phone': phone,
        'address': address,
        'email': email,
        'company_id': company_id,
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

  Future<bool?> DeleteBranch({
    required String id,
  }) async {
    try {
      String url = "http://127.0.0.1:8000/api/admin/branches/delete_branches";
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
