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
  const SupervisiorStatisticScreen({super.key, required this.employeeCount});
  final Map<String, int> employeeCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('employees statistic point'),
        backgroundColor: Colors.blueAccent,
        shadowColor: Colors.black,
        elevation: 2,
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: [
          Card(
            color: Colors.white,
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Employee point:',
              ),
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Employee Count: ${employeeCount['employee_count']}',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Customer Service Count: ${employeeCount['customer_service_count']}',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

      
     
      

             
           //   Text('Customer Service Count: ${employeeCount['customer_service_count']}'),