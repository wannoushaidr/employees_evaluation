import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/screens/admin/add_accessory_screen.dart';
import 'package:clothes_store/screens/admin/update_branch_screen.dart';
import 'package:clothes_store/screens/admin/update_company_screen.dart';
import 'package:clothes_store/screens/admin/update_employee_screen.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:flutter/material.dart';

import '../../services/company_services.dart';

//   class ShowAllEmployeesScreen extends StatelessWidget {
//   const ShowAllEmployeesScreen({super.key, required this.employees});
//   final List<EmployeeModel?>? employees;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Employees Data Table'),
//       ),
//       drawer: Drawer(
//           child: ListView(children: [
//             Row(children: [
//               Container(
//               height: 60,
//               width: 60,
//               child:ClipRRect(
//                 borderRadius: BorderRadius.circular(60),
//                 child: Image.asset("images/screen.png",
//                 fit:BoxFit.cover,
//               )),
//               ),
//               Expanded(
//                 child: ListTile(
//                 title: Text("user name"),
//                 subtitle: Text("email"),
//               )
//               )
//             ],
//             ),
//             ListTile(
//             leading:Icon(Icons.home),
//               title:Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: MaterialButton(
//               // color: Colors.red,
//               textColor: Colors.black,
//               onPressed: () {
//                 // Navigating to About Us page
//                 Navigator.of(context).pushNamed('home');
//               },
//               // leading:Icon(Icons.home),
//               child: const Text("add new",textAlign: TextAlign.left,),

//             ),
//               )
//             ),
//             ListTile(
//               leading:Icon(Icons.home),
//               title:Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: MaterialButton(
//               // color: Colors.red,
//               textColor: Colors.black,
//               onPressed: () {
//                 // Navigating to About Us page
//                 Navigator.of(context).pushNamed('home');
//               },
//               // leading:Icon(Icons.home),
//               child: const Text("statistics",textAlign: TextAlign.left,),

//             ),
//               )
//             ),
//             ListTile(
//              leading:Icon(Icons.home),
//               title:Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: MaterialButton(
//               // color: Colors.red,
//               textColor: Colors.black,
//               onPressed: () {
//                 // Navigating to About Us page
//                 Navigator.of(context).pushNamed('showEmployees');
//               },
//               // leading:Icon(Icons.home),
//               child: const Text("employees",textAlign: TextAlign.left,),

//             ),
//               )
//             ),
//             ListTile(
//               leading:Icon(Icons.home),
//               title:Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: MaterialButton(
//               // color: Colors.red,
//               textColor: Colors.black,
//               onPressed: () {
//                 // Navigating to About Us page
//                 Navigator.of(context).pushNamed('showBranches');
//               },
//               // leading:Icon(Icons.home),
//               child: const Text("branches",textAlign: TextAlign.left,),

//             ),
//               )
//             ),
//             ListTile(
//               leading:Icon(Icons.home),
//               title:Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: MaterialButton(
//               // color: Colors.red,
//               textColor: Colors.black,
//               onPressed: () {
//                 // Navigating to About Us page
//                 Navigator.of(context).pushNamed('home');
//               },
//               // leading:Icon(Icons.home),
//               child: const Text("go to home",textAlign: TextAlign.left,),

//             ),
//               )
//             )
//           ],),
//          ),

//       body: SingleChildScrollView(
//         child: DataTable(
//           columns: const [
//             DataColumn(label: Text('ID')),
//             DataColumn(label: Text('Name')),
//             DataColumn(label: Text('description')),
//             DataColumn(label: Text('number')),
//             DataColumn(label: Text('gender')),
//             DataColumn(label: Text('position')),
//             DataColumn(label: Text('active')),
//             DataColumn(label: Text('branch_id')),
//             DataColumn(label: Text('leader_id')),
//             DataColumn(label: Text('Actions')),
//           ],
//           rows: employees!.map((employee) {
//             return DataRow(cells: [
//               DataCell(Text(employee!.id.toString())),
//               DataCell(Text(employee.name)),
//               DataCell(Text(employee.description)),
//               DataCell(Text(employee.number.toString())),
//               DataCell(Text(employee.gender)),
//               DataCell(Text(employee.position)),
//               DataCell(Text(employee.active)),
//               DataCell(Text(employee.branch_id.toString())),
//               DataCell(Text(employee.leader_id != null
//                   ? employee.leader_id.toString()
//                   : '')),
//               DataCell(
//                 Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.edit),
//                       onPressed: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return UpdateEmployeeScreen(
//                             employee: employee,
//                           );
//                         }));
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.delete),
//                       onPressed: () async {
//                         AppEmployeesService aes = new AppEmployeesService();
//                         bool? result = await aes.DeleteEmployee(
//                             id: employee.id.toString());
//                         if (result == true) {
//                           print('success');
//                           Navigator.pop(context);
//                         } else {
//                           print('error');
//                         }
//                         // Navigator.push(context,
//                         //     MaterialPageRoute(builder: (context) {
//                         //   return UpdateCompanyScreen(
//                         //     company: company,
//                         //   );
//                         // }));
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ]);
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

// ///////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////
// ///////////////////////////////////////////////////////////////////////////////////// ///////////////////////////////////////////////////////////////////////////////////

// *******************************************   this is updataed code for above code ****************
import 'package:flutter/material.dart';

class ShowAllEmployeesScreen extends StatelessWidget {
  const ShowAllEmployeesScreen({super.key, required this.employees});
  final List<EmployeeModel?>? employees;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees Data Table'),
        backgroundColor: const Color.fromARGB(255, 39, 95, 193),
        shadowColor: Colors.black,
        elevation: 2,
      ),

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

      body: employees == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: const Color.fromARGB(255, 219, 219, 219),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DataTable(
                          headingRowColor: WidgetStateProperty.all(
                              const Color.fromARGB(255, 186, 184, 184)),
                          dataRowColor: WidgetStateProperty.all(
                              const Color.fromARGB(255, 255, 255, 255)),
                          columns: const [
                            DataColumn(
                                label: Text(
                              'ID',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              'Name',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            // DataColumn(
                            //     label: Text(
                            //   'Description',
                            //   style: TextStyle(fontWeight: FontWeight.bold),
                            // )),
                            // DataColumn(
                            //     label: Text(
                            //   'Number',
                            //   style: TextStyle(fontWeight: FontWeight.bold),
                            // )),
                            DataColumn(
                                label: Text(
                              'Gender',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              'Position',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              'Active',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              'Branch ID',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              'Leader ID',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              'email',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              'user id',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              'Actions',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ],
                          rows: employees!.map((employee) {
                            return DataRow(cells: [
                              DataCell(Text(employee!.id.toString())),
                              DataCell(Text(employee.name)),
                              // DataCell(Text(employee.description)),
                              // DataCell(Text(employee.number.toString())),
                              DataCell(Text(employee.gender)),
                              DataCell(Text(employee.position)),
                              DataCell(Text(employee.active)),
                              DataCell(Text(employee.branch_id.toString())),
                              DataCell(Text(employee.leader_id != null
                                  ? employee.leader_id.toString()
                                  : '')),
                              DataCell(Text(employee.email)),
                              DataCell(Text(employee.user_id.toString())),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return UpdateEmployeeScreen(
                                            employee: employee,
                                          );
                                        }));
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        AppEmployeesService aes =
                                            AppEmployeesService();
                                        bool? result = await aes.DeleteEmployee(
                                            id: employee.id.toString());
                                        if (result == true) {
                                          print('Success');
                                          Navigator.pop(context);
                                        } else {
                                          print('Error');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
