import 'package:clothes_store/models/accessory_model.dart';
import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/models/point_model.dart';
import 'package:clothes_store/screens/admin/update_accessory_screen.dart';
import 'package:clothes_store/screens/admin/update_branch_screen.dart';
import 'package:clothes_store/screens/admin/update_company_screen.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:clothes_store/services/point_services.dart';
import 'package:flutter/material.dart';

// class customerServiveStatisticScreen extends StatelessWidget {
//   const customerServiveStatisticScreen({super.key, required this.employeeCount, List<EmployeeModel?>? employees});
//   final Map<String, int> employeeCount;

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('managers statistic point'),
//         backgroundColor: Colors.blueAccent,
//         shadowColor: Colors.black,
//         elevation: 2,
//       ),
//       body: GridView(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, // Number of columns
//           childAspectRatio:
//               (screenWidth / 2) / 150, // Adjust height dynamically
//           crossAxisSpacing: 20, // Space between columns
//           mainAxisSpacing: 20, // Space between rows
//         ),
//         children: [
//           Card(
//             color: Colors.white,
//             elevation: 5,
//             margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(18),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Text(
//                     'Employee Count:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     '${employeeCount['employee_count'] ?? 0}',
//                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Card(
//             color: Colors.white,
//             elevation: 5,
//             margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(18),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Text(
//                     'Customer Service Count:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     '${employeeCount['customer_service_count'] ?? 0}',
//                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Card(
//             color: Colors.white,
//             elevation: 5,
//             margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(18),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Text(
//                     'Supervisor Count:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     '${employeeCount['supervisor_count'] ?? 0}',
//                     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:clothes_store/models/employee_model.dart';
import 'package:flutter/material.dart';  

class CustomerServiceStatisticScreen extends StatelessWidget {  
  const CustomerServiceStatisticScreen({super.key,required this.employees});  
 final Map<String, int> employees;
  @override  
  Widget build(BuildContext context) {  
    var screenWidth = MediaQuery.of(context).size.width;  

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
                    'Employee Count:',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                  ),  
                  Text(  
                    '${employees['employee_count'] ?? 0}',  
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
                    'points sum:',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                  ),  
                  Text(  
                    '${employees['points_sum'] ?? 0}',  
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
                    'evaluation',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                  ),  
                  Text(  
                    '${employees['evaluation'] ?? 0}',  
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