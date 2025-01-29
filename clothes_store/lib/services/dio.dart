// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';  
// import 'package:flutter/material.dart';  

// // Rename the function to avoid conflict with Dio class  
// Dio dio({required Map<String, String> additionalHeaders,String? token}) {  
//   final Dio dio = new Dio(); // Use the constructor without the `new` keyword (optional in Dart)  
//   dio.options.baseUrl = "http://127.0.0.1:8000/api"; // Base URL for your API 
//   dio.options.headers['Content-Type'] = 'application/json'; // Set Content-Type  
//     dio.options.headers['Accept'] = 'application/json'; // Set Content-Type  
//     token !=null ? dio.options.headers['Authorization'] = 'Bearer $token' : dio.options.headers['Authorization'];
//   return dio; // Return the Dio instance  
// }