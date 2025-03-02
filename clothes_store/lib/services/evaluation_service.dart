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
 }