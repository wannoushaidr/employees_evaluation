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

import '../../services/company_services.dart';








import 'package:clothes_store/models/employee_model.dart';
import 'package:flutter/material.dart';  



class statistics_screen extends StatelessWidget {
  const statistics_screen(
      {super.key,
      required this.branchesCount,
      required this.points,
      required this.employeeCount});
  final int branchesCount;
  final List<int?> points;
  final Map<String, int> employeeCount;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    int totalPoints =
        points.fold(0, (previous, current) => previous + (current ?? 0));
   
    // Function to determine font size based on screen width  
    double getFontSize() {  
      if (screenWidth < 400) {  
        return 100; // Smaller font size for small screens  
      } else if (screenWidth < 600) {  
        return 100; // Medium font size for medium screens  
      } else {  
        return 30; // Normal font size for large screens  
      }  
    }  

    var fontSize2 = getFontSize(); // Call the function once  

    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Managers Statistic Point'),  
        backgroundColor: Colors.blueAccent,  
        shadowColor: Colors.black,  
        elevation: 2,  
      ),  
      body: GridView(  
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
          crossAxisCount: screenWidth < 600 ? 1 : 2, // Number of columns  
          childAspectRatio: (screenWidth / 2) / 150, // Adjust height dynamically  
          crossAxisSpacing: 20, // Space between columns  
          mainAxisSpacing: 20, // Space between rows  
        ),  
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
              child: Column(  
                // mainAxisAlignment: MainAxisAlignment.center, // Center content vertically  
                children: [  
                  const Text(  
                    'branchesCount:',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                  ),  
                  Text(  
                    '${branchesCount ?? 0}',  
                    style: TextStyle(fontSize: fontSize2, fontWeight: FontWeight.bold), // Dynamic font size  
                  ),  
                ],  
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
              child: Column(  
                // mainAxisAlignment: MainAxisAlignment.center, // Center content vertically  
                children: [  
                  const Text(  
                    'totla point ',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                  ),  
                  Text(  
                    totalPoints.toString(),  
                    style: TextStyle(fontSize: fontSize2, fontWeight: FontWeight.bold), // Dynamic font size  
                  ),  
                ],  
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
              child: Column(  
                // mainAxisAlignment: MainAxisAlignment.center, // Center content vertically  
                children: [  
                  const Text(  
                    'employeeCount ',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                  ),  
                  Text(  
                    '${employeeCount['employee_count']} ',  
                    style: TextStyle(fontSize: fontSize2, fontWeight: FontWeight.bold), // Dynamic font size  
                  ),  
                ],  
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
              child: Column(  
                // mainAxisAlignment: MainAxisAlignment.center, // Center content vertically  
                children: [  
                  const Text(  
                    'customer_service_count ',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                  ),  
                  Text(  
                    '${employeeCount['customer_service_count']}',  
                    style: TextStyle(fontSize: fontSize2, fontWeight: FontWeight.bold), // Dynamic font size  
                  ),  
                ],  
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
              child: Column(  
                // mainAxisAlignment: MainAxisAlignment.center, // Center content vertically  
                children: [  
                  const Text(  
                    'manager_count',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                  ),  
                  Text(  
                    '${employeeCount['manager_count']}',  
                    style: TextStyle(fontSize: fontSize2, fontWeight: FontWeight.bold), // Dynamic font size  
                  ),  
                ],  
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
              child: Column(  
                // mainAxisAlignment: MainAxisAlignment.center, // Center content vertically  
                children: [  
                  const Text(  
                    'supervisor_count',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                  ),  
                  Text(  
                    '${employeeCount['supervisor_count']}',  
                    style: TextStyle(fontSize: fontSize2, fontWeight: FontWeight.bold), // Dynamic font size  
                  ),  
                ],  
              ),  
            ),  
          ),   
        ],  
      ),  
    );  
  }


}