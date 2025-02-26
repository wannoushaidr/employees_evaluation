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

// class SupervisiorStatisticScreen extends StatelessWidget {
//   const SupervisiorStatisticScreen({super.key, required this.employeeCount, List<EmployeeModel?>? employees});
//   final Map<String, int> employeeCount;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('employees statistic point'),
//         backgroundColor: Colors.blueAccent,
//         shadowColor: Colors.black,
//         elevation: 2,
//       ),
//       body: GridView(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, childAspectRatio: 2),
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
//               child: Text(
//                 'Employee point:',
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
//               child: Text(
//                 'Employee Count: ${employeeCount['employee_count']}',
//                 style: TextStyle(fontSize: 18),
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
//               child: Text(
//                 'Customer Service Count: ${employeeCount['customer_service_count']}',
//                 style: TextStyle(fontSize: 18),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

      
     
      


class SupervisiorStatisticScreen extends StatelessWidget {  
  const SupervisiorStatisticScreen({super.key,required this.employeeCount, List<EmployeeModel?>? employees});  
 final Map<String, int> employeeCount;
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
                    'total_points:',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                  ),  
                  Text(  
                    '${employeeCount['total_points'] ?? 0}',  
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
                    'customer_service_count:',  
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                  ),  
                  Text(  
                    '${employeeCount['customer_service_count'] ?? 0}',  
                    style: TextStyle(fontSize: fontSize2, fontWeight: FontWeight.bold), // Dynamic font size  
                  ),  
                ],  
              ),  
            ),  
          ),  
          // Card(  
          //   color: Colors.white,  
          //   elevation: 5,  
          //   margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),  
          //   shape: RoundedRectangleBorder(  
          //     borderRadius: BorderRadius.circular(18),  
          //   ),  
          //   child: Padding(  
          //     padding: const EdgeInsets.all(8.0),  
          //     child: Column(  
          //       // mainAxisAlignment: MainAxisAlignment.center, // Center content vertically  
          //       children: [  
          //         Text(  
          //           'evaluation',  
          //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
          //         ),  
          //         Text(  
          //           '${employeeCount['supervisor_count'] ?? 0}',  
          //           style: TextStyle(fontSize: fontSize2, fontWeight: FontWeight.bold), // Dynamic font size  
          //         ),  
          //       ],  
          //     ),  
          //   ),  
          // ),  
        ],  
      ),  
    );  
  }


}