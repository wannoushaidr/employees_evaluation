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
      print("responseBody");
      print(responseBody);

      // Decode the response as a List<dynamic> 
      List<dynamic> jsonData = jsonDecode(responseBody); 
      print("jsonData"); 
      print(jsonData);
      List<BranchModel> branches = jsonData.map((branch) => BranchModel.fromJson(branch)).toList();
      

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


//   Future<int?> getBranchesCount() async {
//   try {
//     String url = "http://127.0.0.1:8000/api/admin/branches/get_branches_count";
//     http.Response response = await http.get(Uri.parse(url));
    
//     if (response.statusCode == 200) {
//       // return int.parse(response.body); // Assuming response.body is a single string
//       Map<String, dynamic> data = jsonDecode(response.body);
//         return data['count'] as int;
//     } else {
//       return null;
//     }
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }

Future<int?> getBranchesCount() async {
  try {
    String url = "http://127.0.0.1:8000/api/admin/branches/get_branches_count";
    http.Response response = await http.get(Uri.parse(url));

    // Split the response body into lines
    List<String> lines = response.body.split('\n');
    
    // Skip the first two lines and join the remaining lines
    String responseBody = lines.skip(2).join('\n');

    print(responseBody); // Print the cleaned response body for debugging

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(responseBody);
      return data['count'] as int;
    } else {
      return null;
    }
  } catch (e) {
    print(e);
    return null;
  }
}


}
