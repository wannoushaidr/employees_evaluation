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



// class statistics_screen extends StatelessWidget {
//   const statistics_screen(
//       {super.key,
//       required this.branchesCount,
//       required this.points,
//       required this.employeeCount});
//   final int branchesCount;
//   final List<int?> points;
//   final Map<String, int> employeeCount;

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     int totalPoints =
//         points.fold(0, (previous, current) => previous + (current ?? 0));
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Statistics'),
//         backgroundColor: const Color.fromARGB(255, 39, 95, 193),
//         shadowColor: Colors.black,
//         elevation: 2,
//       ),

      // drawer: Drawer(
      //     child: ListView(children: [
      //       Row(children: [
      //         Container(
      //         height: 60,
      //         width: 60,
      //         child:ClipRRect(
      //           borderRadius: BorderRadius.circular(60),
      //           child: Image.asset("images/screen.png",
      //           fit:BoxFit.cover,
      //         )),
      //         ),
      //         Expanded(
      //           child: ListTile(
      //           title: Text("user name"),
      //           subtitle: Text("email"),
      //         )
      //         )
      //       ],
      //       ),
      //       ListTile(
      //       leading:Icon(Icons.home),
      //         title:Container(
      //       margin: EdgeInsets.symmetric(horizontal: 20),
      //       child: MaterialButton(
      //         // color: Colors.red,
      //         textColor: Colors.black,
      //         onPressed: () {
      //           // Navigating to About Us page
      //           Navigator.of(context).pushNamed('home');
      //         },
      //         // leading:Icon(Icons.home),
      //         child: const Text("add new",textAlign: TextAlign.left,),

      //       ),
      //         )
      //       ),
      //       ListTile(
      //         leading:Icon(Icons.home),
      //         title:Container(
      //       margin: EdgeInsets.symmetric(horizontal: 20),
      //       child: MaterialButton(
      //         // color: Colors.red,
      //         textColor: Colors.black,
      //         onPressed: () {
      //           // Navigating to About Us page
      //           Navigator.of(context).pushNamed('statistics_screen');
      //         },
      //         // leading:Icon(Icons.home),
      //         child: const Text("statistics",textAlign: TextAlign.left,),

      //       ),
      //         )
      //       ),
      //       ListTile(
      //        leading:Icon(Icons.home),
      //         title:Container(
      //       margin: EdgeInsets.symmetric(horizontal: 20),
      //       child: MaterialButton(
      //         // color: Colors.red,
      //         textColor: Colors.black,
      //         onPressed: () {
      //           // Navigating to About Us page
      //           Navigator.of(context).pushNamed('showEmployees');
      //         },
      //         // leading:Icon(Icons.home),
      //         child: const Text("employees",textAlign: TextAlign.left,),

      //       ),
      //         )
      //       ),
      //       ListTile(
      //         leading:Icon(Icons.home),
      //         title:Container(
      //       margin: EdgeInsets.symmetric(horizontal: 20),
      //       child: MaterialButton(
      //         // color: Colors.red,
      //         textColor: Colors.black,
      //         onPressed: () {
      //           // Navigating to About Us page
      //           Navigator.of(context).pushNamed('showBranches');
      //         },
      //         // leading:Icon(Icons.home),
      //         child: const Text("branches",textAlign: TextAlign.left,),

      //       ),
      //         )
      //       ),
      //       ListTile(
      //         leading:Icon(Icons.home),
      //         title:Container(
      //       margin: EdgeInsets.symmetric(horizontal: 20),
      //       child: MaterialButton(
      //         // color: Colors.red,
      //         textColor: Colors.black,
      //         onPressed: () {
      //           // Navigating to About Us page
      //           Navigator.of(context).pushNamed('home');
      //         },
      //         // leading:Icon(Icons.home),
      //         child: const Text("go to home",textAlign: TextAlign.left,),

      //       ),
      //         )
      //       )
      //     ],),
      //    ),


// ***********************************************************************************************************************
// ***********************************************************************************************************************
// ***********************************************************************************************************************
// ***********************************************************************************************************************
// ***********************************************************************************************************************
// ***********************************************************************************************************************
// ***********************************************************************************************************************


      
// class statistics_screen extends StatelessWidget {
//   const statistics_screen(
//       {super.key,
//       required this.branchesCount,
//       required this.points,
//       required this.employeeCount});
//   final int branchesCount;
//   final List<int?> points;
//   final Map<String, int> employeeCount;

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     int totalPoints =
//         points.fold(0, (previous, current) => previous + (current ?? 0));
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Statistics'),
//         backgroundColor: const Color.fromARGB(255, 39, 95, 193),
//         shadowColor: Colors.black,
//         elevation: 2,
//       ),


//       body: Container(
//         margin: const EdgeInsets.all(20),
//         child: GridView(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, // Number of columns
//             childAspectRatio:
//                 (screenWidth / 2) / 150, // Adjust height dynamically
//             crossAxisSpacing: 20, // Space between columns
//             mainAxisSpacing: 20, // Space between rows
//           ),
//           children: [
//             Card(
//               color: Colors.white,
//               elevation: 5,
//               //  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Text('Branches Count:',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold)),
//                       Text('$branchesCount',
//                           style: TextStyle(
//                               fontSize: 30, fontWeight: FontWeight.bold)),
//                     ],
//                   )),
//             ),
//             Card(
//               color: Colors.white,
//               elevation: 5,
//               //  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Text('Points:',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold)),
//                     Text('${totalPoints.toString()}',
//                         style: TextStyle(
//                             fontSize: 30, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//               ),
//             ),
//             Card(
//               color: Colors.white,
//               elevation: 5,
//               //  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Text('Employee Count:',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold)),
//                     Text('${employeeCount['employee_count']}',
//                         style: TextStyle(
//                             fontSize: 30, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//               ),
//             ),
//             Card(
//               color: Colors.white,
//               elevation: 5,
//               //  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Text('Customer Service Count:',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold)),
//                     Text('${employeeCount['customer_service_count']}',
//                         style: TextStyle(
//                             fontSize: 30, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//               ),
//             ),
//             Card(
//               color: Colors.white,
//               elevation: 5,
//               //   margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Text('Manager Count:',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold)),
//                     Text('${employeeCount['manager_count']}',
//                         style: TextStyle(
//                             fontSize: 30, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//               ),
//             ),
//             Card(
//               color: Colors.white,
//               elevation: 5,
//               //     margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Text('Supervisor Count:',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold)),
//                     Text('${employeeCount['supervisor_count']}',
//                         style: TextStyle(
//                             fontSize: 30, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//               ),
//             ),

//             // Text('Employee Statistics:',
//             //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           ],
//         ),
//       ),
//     );
//   }
// }







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