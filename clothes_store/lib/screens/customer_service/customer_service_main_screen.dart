// import 'package:clothes_store/models/company_model.dart';
// import 'package:clothes_store/models/employee_model.dart';
// import 'package:clothes_store/models/point_model.dart';
// import 'package:clothes_store/screens/customer_service/customer_service_points.dart';
// import 'package:clothes_store/screens/shared_screen/login_screen.dart';
// import 'package:clothes_store/screens/manager/activate_employee_screen.dart';
// import 'package:clothes_store/screens/manager/manager_statistics_screen.dart';
// import 'package:clothes_store/screens/manager/show_all_managers_employees.dart';
// import 'package:clothes_store/screens/admin/show_all_companies_screen.dart';
// import 'package:clothes_store/screens/shared_screen/user_profile_screen.dart';
// import 'package:clothes_store/services/branch_services.dart';
// import 'package:clothes_store/services/company_services.dart';
// import 'package:clothes_store/services/employee_services.dart';
// import 'package:clothes_store/services/point_services.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:clothes_store/services/auth.dart';

// import '../../services/auth_remastered.dart'; // Import your Auth class

// class CutmoerServiceMainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<Auth>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text('customer sercice main screen')),

//       drawer: Drawer(
//                               child:Consumer<Auth>(builder:(context,auth,child){
//                                 // if (!  auth!.authenticated){
//                                 if (!  auth.authenticated){
//                                   return ListView(
//                                     children: [
//                                       ListTile(
//                                   leading:const Icon(Icons.login),
//                                   title:const Text("loginn"),
//                                   onTap: (){
//                                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
//                                   },
//                                   )],
//                                 );
//                                 // );

//                                 }
//                                 else{
//                               return ListView(children: [

//                             IntrinsicHeight(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: DrawerHeader(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const CircleAvatar(
//                                 backgroundColor: Colors.blue,
//                                 radius: 30,
//                               ),
//                               const SizedBox(height: 10),
//                               Text(auth.user.name, style: const TextStyle(color: Colors.black)),
//                               const SizedBox(height: 10),
//                               Text(auth.user.email, style: const TextStyle(color: Colors.black)),
//                               // const SizedBox(height: 10),
//                               // Text(auth.user.role, style: const TextStyle(color: Colors.black)),
//                             ],
//                           ),
//                           decoration: const BoxDecoration(
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                             ListTile(
//                               title:ElevatedButton(
//                                           onPressed: () async {
//                                             // Your new button functionality goes here
//                                             print('profile');

//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) {
//                                                     return UserProfile();
//                                                   },
//                                                 ),
//                                               );
//                                             // Example: Fetch another set of data or navigate to a different screen
//                                           },
//                                           child: Text('profile'),
//                                         ),
//                             ),

//                     ListTile(
//                               title:ElevatedButton(
//                                           onPressed: () async {
//                                             // Your new button functionality goes here
//                                             print('ManagerMainScreen');

//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) {
//                                                     return CutmoerServiceMainScreen();
//                                                   },
//                                                 ),
//                                               );
//                                             // Example: Fetch another set of data or navigate to a different screen
//                                           },
//                                           child: Text('main screen '),
//                                         ),
//                             ),

//                             ListTile(
//                               title:ElevatedButton(
//                                           onPressed: () async {
//                                             // Your new button functionality goes here
//                                             print('statistic');
//                                             AppPointsService aas = AppPointsService();
//                                                     // AppEmployeesService aas3 = AppEmployeesService();
//                                                       // Map<String, int>? employeeCount = await aas3.getSupervisorsAndCustomerServiceEmployees(auth.user.id);
//                                                     List<PointModel?>? points = await aas.GetEmployeePoint(auth.user.id);

//                                             if (points != null) {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) {
//                                                     return CustomerServicePoints(points: points,);
//                                                   },
//                                                 ),
//                                               );
//                                             }
//                                             // Example: Fetch another set of data or navigate to a different screen
//                                           },
//                                           child: Text('points'),
//                                         ),
//                             ),

//                             ListTile(
//                             title:ElevatedButton(
//                                           // onPressed: () async {
//                                             // Your new button functionality goes here
//                                             onPressed: () async {
//                                             AppEmployeesService acp = AppEmployeesService();
//                                             List<EmployeeModel?>? employees = await acp.GetMyAtivateEmployee(auth.user.id);
//                                             print(employees);

//                                             // if (employees != null) {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) {
//                                                     return showActivateEmployees(employees: employees);
//                                                   },
//                                                 ),
//                                               );
//                                             // }
//                                             },
//                                             // Example: Fetch another set of data or navigate to a different screen
//                                           // },
//                                           child: Text('notification'),
//                                         ),
//                             ),

//                             ListTile(
//                             title:ElevatedButton(
//                                           // onPressed: () async {
//                                             // Your new button functionality goes here
//                                             onPressed: () async {
//                                             AppEmployeesService acp = AppEmployeesService();
//                                             List<EmployeeModel?>? employees = await acp.GetMyEmployeesEnformation(auth.user.id);
//                                             print("employees");
//                                             print(employees);

//                                             // if (employees != null) {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) {
//                                                     return showEmployeesByManages(employees: employees);
//                                                   },
//                                                 ),
//                                               );
//                                             // }
//                                             },
//                                             // Example: Fetch another set of data or navigate to a different screen
//                                           // },
//                                           child: Text('statistic'),
//                                         ),
//                             ),

//                           ListTile(
//                               leading:const Icon(Icons.logout),
//                               title:const Text("logout"),
//                               onTap: (){
//                                 Provider.of<Auth>(context,listen: false)
//                                   .logout();
//                                    Navigator.pushReplacementNamed(context, 'mainscreen');
//                               },
//                             ),

//                           ],
//                           );
//                             }
//                       })
//                       ),

//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(height: 10),
//             Text('Name: ${auth.user.name}'),
//             SizedBox(height: 5),
//             Text('Email: ${auth.user.email}'),
//             SizedBox(height: 5),
//             Text('Role: ${auth.user.role}'),
//             ElevatedButton(
//               onPressed: () async {
//                 AppEmployeesService acp = AppEmployeesService();
//                 List<EmployeeModel?>? employees = await acp.GetMyEmployeesEnformation(auth.user.id);
//                 print(employees);

//                 if (employees != null) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return showEmployeesByManages(employees: employees);
//                       },
//                     ),
//                   );
//                 }
//               },
//               child: Text('Show Employees by Managers'),
//             ),

//             ElevatedButton(
//               onPressed: () async {
//                 // Your new button functionality goes here
//                 print('Second button pressed');
//                 AppPointsService aas = AppPointsService();
//                         // List<PointModel?>? points = await aas.GetAllPoint();
//                         AppEmployeesService aas3 = AppEmployeesService();
//                           Map<String, int>? employeeCount = await aas3.getSupervisorsAndCustomerServiceEmployees(auth.user.id);

//                 if (employeeCount != null) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return ManagerStatisticScreen(employeeCount: employeeCount,);
//                       },
//                     ),
//                   );
//                 }
//                 // Example: Fetch another set of data or navigate to a different screen
//               },
//               child: Text('Second Button'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:clothes_store/models/company_model.dart';
// import 'package:clothes_store/models/employee_model.dart';
// import 'package:clothes_store/models/point_model.dart';
// import 'package:clothes_store/screens/customer_service/customer_service_points.dart';
// import 'package:clothes_store/screens/shared_screen/login_screen.dart';
// import 'package:clothes_store/screens/manager/activate_employee_screen.dart';
// import 'package:clothes_store/screens/manager/manager_statistics_screen.dart';
// import 'package:clothes_store/screens/manager/show_all_managers_employees.dart';
// import 'package:clothes_store/screens/admin/show_all_companies_screen.dart';
// import 'package:clothes_store/screens/shared_screen/user_profile_screen.dart';
// import 'package:clothes_store/services/branch_services.dart';
// import 'package:clothes_store/services/company_services.dart';
// import 'package:clothes_store/services/employee_services.dart';
// import 'package:clothes_store/services/point_services.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:clothes_store/services/auth.dart';

// import '../../services/auth_remastered.dart'; // Import your Auth class

// class CutmoerServiceMainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<Auth>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'customer service main screen',
//           // style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.blueAccent,
//         shadowColor: Colors.black,
//         elevation: 2,
//       ),
//       drawer: Drawer(
//         child: Consumer<Auth>(builder: (context, auth, child) {
//           // if (!  auth!.authenticated){
//           if (!auth.authenticated) {
//             return ListView(
//               children: [
//                 ListTile(
//                   leading: const Icon(Icons.login),
//                   title: const Text("loginn"),
//                   onTap: () {
//                     Navigator.of(context).push(
//                         MaterialPageRoute(builder: (context) => LoginScreen()));
//                   },
//                 )
//               ],
//             );
//             // );
//           } else {
//             return ListView(
//               children: [
//                 IntrinsicHeight(
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: DrawerHeader(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const CircleAvatar(
//                                 backgroundColor: Colors.blue,
//                                 radius: 30,
//                               ),
//                               const SizedBox(height: 10),
//                               Text(auth.user.name,
//                                   style: const TextStyle(color: Colors.black)),
//                               const SizedBox(height: 10),
//                               Text(auth.user.email,
//                                   style: const TextStyle(color: Colors.black)),
//                               // const SizedBox(height: 10),
//                               // Text(auth.user.role, style: const TextStyle(color: Colors.black)),
//                             ],
//                           ),
//                           decoration: const BoxDecoration(
//                             color: Colors.blue,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 ListTile(
//                   title: ElevatedButton(
//                     onPressed: () async {
//                       // Your new button functionality goes here
//                       print('profile');

//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) {
//                             return UserProfile();
//                           },
//                         ),
//                       );
//                       // Example: Fetch another set of data or navigate to a different screen
//                     },
//                     child: Text('profile'),
//                   ),
//                 ),
//                 ListTile(
//                   title: ElevatedButton(
//                     onPressed: () async {
//                       // Your new button functionality goes here
//                       print('ManagerMainScreen');

//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) {
//                             return CutmoerServiceMainScreen();
//                           },
//                         ),
//                       );
//                       // Example: Fetch another set of data or navigate to a different screen
//                     },
//                     child: Text('main screen '),
//                   ),
//                 ),
//                 ListTile(
//                   title: ElevatedButton(
//                     onPressed: () async {
//                       // Your new button functionality goes here
//                       print('statistic');
//                       AppPointsService aas = AppPointsService();
//                       // AppEmployeesService aas3 = AppEmployeesService();
//                       // Map<String, int>? employeeCount = await aas3.getSupervisorsAndCustomerServiceEmployees(auth.user.id);
//                       List<PointModel?>? points =
//                           await aas.GetEmployeePoint(auth.user.id);

//                       if (points != null) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) {
//                               return CustomerServicePoints(
//                                 points: points,
//                               );
//                             },
//                           ),
//                         );
//                       }
//                       // Example: Fetch another set of data or navigate to a different screen
//                     },
//                     child: Text('points'),
//                   ),
//                 ),
//                 ListTile(
//                   title: ElevatedButton(
//                     // onPressed: () async {
//                     // Your new button functionality goes here
//                     onPressed: () async {
//                       AppEmployeesService acp = AppEmployeesService();
//                       List<EmployeeModel?>? employees =
//                           await acp.GetMyAtivateEmployee(auth.user.id);
//                       print(employees);

//                       // if (employees != null) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) {
//                             return showActivateEmployees(employees: employees);
//                           },
//                         ),
//                       );
//                       // }
//                     },
//                     // Example: Fetch another set of data or navigate to a different screen
//                     // },
//                     child: Text('notification'),
//                   ),
//                 ),
//                 ListTile(
//                   title: ElevatedButton(
//                     // onPressed: () async {
//                     // Your new button functionality goes here
//                     onPressed: () async {
//                       AppEmployeesService acp = AppEmployeesService();
//                       List<EmployeeModel?>? employees =
//                           await acp.GetMyEmployeesEnformation(auth.user.id);
//                       print("employees");
//                       print(employees);

//                       // if (employees != null) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) {
//                             return showEmployeesByManages(employees: employees);
//                           },
//                         ),
//                       );
//                       // }
//                     },
//                     // Example: Fetch another set of data or navigate to a different screen
//                     // },
//                     child: Text('statistic'),
//                   ),
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.logout),
//                   title: const Text("logout"),
//                   onTap: () {
//                     Provider.of<Auth>(context, listen: false).logout();
//                     Navigator.pushReplacementNamed(context, 'mainscreen');
//                   },
//                 ),
//               ],
//             );
//           }
//         }),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(height: 10),
//             Text('Name: ${auth.user.name}'),
//             SizedBox(height: 5),
//             Text('Email: ${auth.user.email}'),
//             SizedBox(height: 5),
//             Text('Role: ${auth.user.role}'),
//             ElevatedButton(
//               onPressed: () async {
//                 AppEmployeesService acp = AppEmployeesService();
//                 List<EmployeeModel?>? employees =
//                     await acp.GetMyEmployeesEnformation(auth.user.id);
//                 print(employees);

//                 if (employees != null) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return showEmployeesByManages(employees: employees);
//                       },
//                     ),
//                   );
//                 }
//               },
//               child: Text('Show Employees by Managers'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 // Your new button functionality goes here
//                 print('Second button pressed');
//                 AppPointsService aas = AppPointsService();
//                 // List<PointModel?>? points = await aas.GetAllPoint();
//                 AppEmployeesService aas3 = AppEmployeesService();
//                 Map<String, int>? employeeCount = await aas3
//                     .getSupervisorsAndCustomerServiceEmployees(auth.user.id);

//                 if (employeeCount != null) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return ManagerStatisticScreen(
//                           employeeCount: employeeCount,
//                         );
//                       },
//                     ),
//                   );
//                 }
//                 // Example: Fetch another set of data or navigate to a different screen
//               },
//               child: Text('Second Button'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/models/point_model.dart';
import 'package:clothes_store/screens/admin/show_all_points_screen.dart';
import 'package:clothes_store/screens/customer_service/customer_service_points.dart';
import 'package:clothes_store/screens/shared_screen/login_screen.dart';
import 'package:clothes_store/screens/manager/activate_employee_screen.dart';
import 'package:clothes_store/screens/manager/manager_statistics_screen.dart';
import 'package:clothes_store/screens/manager/show_all_managers_employees.dart';
import 'package:clothes_store/screens/admin/show_all_companies_screen.dart';
import 'package:clothes_store/screens/shared_screen/user_profile_screen.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:clothes_store/services/company_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:clothes_store/services/point_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clothes_store/services/auth.dart';
import '../../services/auth_remastered.dart';
import '../admin/statistics_screen.dart'; // Import your Auth class

class CutmoerServiceMainScreen extends StatefulWidget {
  @override
  State<CutmoerServiceMainScreen> createState() =>
      _CutmoerServiceMainScreenState();
}

class _CutmoerServiceMainScreenState extends State<CutmoerServiceMainScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('customer service main screen'),
        backgroundColor: Colors.blueAccent,
        shadowColor: Colors.black,
        elevation: 2,
        automaticallyImplyLeading: MediaQuery.of(context).size.width <= 600,
      ),
      drawer: _buildDrawer(auth, context),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check if the width is greater than a certain threshold
          bool isWideScreen =
              constraints.maxWidth > 600; // Example width threshold
          //   Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage('assets/images/clothes.jpg'), opacity: 0.3),
          // ),
          // child:
          return Row(
            children: [
              if (isWideScreen) // Show drawer for wider screens
                _buildDrawer(auth, context),
              Expanded(
                child: _buildBody(auth, context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDrawer(Auth auth, BuildContext context) {
    return Drawer(
      child: Consumer<Auth>(builder: (context, auth, child) {
        if (!auth.authenticated) {
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.login),
                title: const Text("loginn"),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              )
            ],
          );
        } else {
          return ListView(
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: DrawerHeader(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/clothes-background.jpg'),
                              //NetworkImage(auth.user.image??''),
                              //  backgroundColor: Colors.blue,
                              radius: 35,
                            ),
                            const SizedBox(height: 10),
                            Text(auth.user.name,
                                style: const TextStyle(color: Colors.black)),
                            Text(auth.user.email,
                                style: const TextStyle(color: Colors.black)),
                          ],
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ..._buildDrawerItems(auth, context),
            ],
          );
        }
      }),
    );
  }

  List<Widget> _buildDrawerItems(Auth auth, BuildContext context) {
    return [
      ListTile(
        leading: const Icon(Icons.person), // Add an icon for the profile
        title: const Text('Profile'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserProfile()),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.home), // Add an icon for the main screen
        title: const Text('Main Screen'),
        onTap: () async {
          print('MainScreen');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CutmoerServiceMainScreen()),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.point_of_sale), // Add an icon for points
        title: const Text('Points'),
        onTap: () async {
          print('points');
        //   AppPointsService aas = AppPointsService();
        //   List<PointModel?>? points = await aas.GetEmployeePoint(auth.user.id);

        //   if (points != null) {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) {
        //           return CustomerServicePoints(
        //             points: points,
        //           );
        //         },
        //       ),
        //     );
        //   }
        // },

        AppPointsService aas = AppPointsService();
          List<PointModel?>? points = await aas.GetEmployeePointonly(auth.user.id);
          
          print("middle done");

          if (points != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CustomerServicePoints(points: points);
                },
              ),
            );
          }
        },
      ),
      ListTile(
        leading: const Icon(Icons.notifications), // Notification icon
        title: const Text('Notifications'),
        onTap: () async {
          AppEmployeesService acp = AppEmployeesService();
          List<EmployeeModel?>? employees =
              await acp.GetMyAtivateEmployee(auth.user.id);
          print(employees);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return showActivateEmployees(employees: employees);
              },
            ),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.pie_chart), // Statistic icon
        title: const Text('Statistics'),
        onTap: () async {
          AppEmployeesService acp = AppEmployeesService();
          List<EmployeeModel?>? employees =
              await acp.GetMyEmployeesEnformation(auth.user.id);
          print("employees");
          print(employees);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return showEmployeesByManages(employees: employees);
              },
            ),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text("Logout"),
        onTap: () {
          Provider.of<Auth>(context, listen: false).logout();
          Navigator.pushReplacementNamed(context, 'LoginScreen');
        },
      ),
    ];
  }

  Widget _buildBody(Auth auth, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          Text(
            'Name: ${auth.user.name}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Email: ${auth.user.email}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'Role: ${auth.user.role}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200, 50),
              backgroundColor: Colors.blueAccent,
            ),
            onPressed: () async {
              AppEmployeesService acp = AppEmployeesService();
              List<EmployeeModel?>? employees =
                  await acp.GetMyEmployeesEnformation(auth.user.id);
              if (employees != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return showEmployeesByManages(employees: employees);
                    },
                  ),
                );
              }
            },
            child: Text(
              'Show Employees by Managers',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 5),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200, 50),
              backgroundColor: Colors.blueAccent,
            ),
            onPressed: () async {
              AppPointsService aas = AppPointsService();
              AppEmployeesService aas3 = AppEmployeesService();
              Map<String, int>? employeeCount = await aas3
                  .getSupervisorsAndCustomerServiceEmployees(auth.user.id);

              if (employeeCount != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ManagerStatisticScreen(
                        employeeCount: employeeCount,
                      );
                    },
                  ),
                );
              }
            },
            child: Text(
              'Second Button',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
