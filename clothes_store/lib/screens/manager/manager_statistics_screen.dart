

import 'package:clothes_store/models/accessory_model.dart';
import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/point_model.dart';
import 'package:clothes_store/screens/update_accessory_screen.dart';
import 'package:clothes_store/screens/update_branch_screen.dart';
import 'package:clothes_store/screens/update_company_screen.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:clothes_store/services/point_services.dart';
import 'package:flutter/material.dart';

class ManagerStatisticScreen extends StatelessWidget {
  const ManagerStatisticScreen({super.key,  required this.points,  required this.employeeCount});
  final List<int?> points;
  final Map<String, int> employeeCount;


  @override
  Widget build(BuildContext context) {
  int totalPoints = points.fold(0, (previous, current) => previous + (current ?? 0));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessories Data Table'),
      ),


  
    
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('Branches Count: $branchesCount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text('Points:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(totalPoints.toString()),
              const SizedBox(height: 16),
              Text('Employee Statistics:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Employee Count: ${employeeCount['employee_count']}'),
              Text('Customer Service Count: ${employeeCount['customer_service_count']}'),
              Text('Supervisor Count: ${employeeCount['supervisor_count']}'),
            ],
          ),
        ),
      ),
    );
  }
}

      
     
      
