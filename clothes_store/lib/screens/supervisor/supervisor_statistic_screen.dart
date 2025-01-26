

import 'package:clothes_store/models/accessory_model.dart';
import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/point_model.dart';
import 'package:clothes_store/screens/admin/update_accessory_screen.dart';
import 'package:clothes_store/screens/admin/update_branch_screen.dart';
import 'package:clothes_store/screens/admin/update_company_screen.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:clothes_store/services/point_services.dart';
import 'package:flutter/material.dart';

class SupervisiorStatisticScreen extends StatelessWidget {
  const SupervisiorStatisticScreen({super.key  ,required this.employeeCount});
  final Map<String, int> employeeCount;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('employees statistic point'),
      ),


  
    
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('Branches Count: $branchesCount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              
              const SizedBox(height: 16),
              Text('Employee Statistics:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Employee Count: ${employeeCount['employee_count']}'),
              Text('Customer Service Count: ${employeeCount['customer_service_count']}'),
            ],
          ),
        ),
      ),
    );
  }
}

      
     
      
