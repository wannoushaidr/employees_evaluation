 import 'dart:convert';

 import 'package:clothes_store/models/evaluation_model.dart';


 import 'package:http/http.dart' as http;

 import 'dart:convert';

 class AppEvaluationService {
   Future<List<EvaluationModel?>?> Evaluate_employee() async {
     try {
       String url = "http://127.0.0.1:8000/api/admin/evaluate";
       http.Response response = await http.get(Uri.parse(url));
       //  print(response.body);
       List<String> lines = response.body.split('\n');
       String responseBody = lines.skip(2).join('\n');
       print(responseBody);
       Map<String, dynamic> data = jsonDecode(responseBody);

    List<dynamic> jsonData = data['data'];
       List<EvaluationModel> points = [];
       for (var data in jsonData) {
         EvaluationModel evaluation = EvaluationModel.fromJson(data);
         points.add(evaluation);
       }

       return points;
     } catch (e) {
       print(e);
     }
     return null;
   }


   Future<List<EvaluationModel?>?> GetDailyEvaluation() async {
    print("ss");
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/get_daily_evaluation";
          print("ssdd");
      http.Response response = await http.get(Uri.parse(url));
      print("ss");

      if (response.statusCode == 200) {
        // Split response body into lines and skip the first two lines
        List<String> lines = response.body.split('\n');
        String responseBody = lines.skip(2).join('\n');
        print("ss");

        // Decode the adjusted response body
        List<dynamic> jsonData = jsonDecode(responseBody);
        print("ss");
        List<EvaluationModel> employees = jsonData.map((data) {
          print("ss");
          return EvaluationModel.fromJson(data);
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




  
   Future<List<EvaluationModel?>?> GetWeeklyEvaluation() async {
    print("ss");
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/get_weekly_evaluation";
          print("ssdd");
      http.Response response = await http.get(Uri.parse(url));
      print("ss");

      if (response.statusCode == 200) {
        // Split response body into lines and skip the first two lines
        List<String> lines = response.body.split('\n');
        String responseBody = lines.skip(2).join('\n');
        print("ss");

        // Decode the adjusted response body
        List<dynamic> jsonData = jsonDecode(responseBody);
        print("ss");
        List<EvaluationModel> employees = jsonData.map((data) {
          print("ss");
          return EvaluationModel.fromJson(data);
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





   Future<List<EvaluationModel?>?> GetmonthlyEvaluation() async {
    print("ss");
    try {
      String url =
          "http://127.0.0.1:8000/api/admin/get_monthly_evaluation";
          print("ssdd");
      http.Response response = await http.get(Uri.parse(url));
      print("ss");

      if (response.statusCode == 200) {
        // Split response body into lines and skip the first two lines
        List<String> lines = response.body.split('\n');
        String responseBody = lines.skip(2).join('\n');
        print("ss");

        // Decode the adjusted response body
        List<dynamic> jsonData = jsonDecode(responseBody);
        print("ss");
        List<EvaluationModel> employees = jsonData.map((data) {
          print("ss");
          return EvaluationModel.fromJson(data);
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