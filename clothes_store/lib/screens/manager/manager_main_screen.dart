// import 'package:clothes_store/models/company_model.dart';
// import 'package:clothes_store/models/employee_model.dart';
// import 'package:clothes_store/models/point_model.dart';
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

// class ManagerMainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<Auth>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text('Manager'), backgroundColor: Colors.blueAccent,
//         shadowColor: Colors.black,
//         elevation: 2,
//         automaticallyImplyLeading: MediaQuery.of(context).size.width <= 600,),

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
//                                                     return ManagerMainScreen();
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
//                                                     AppEmployeesService aas3 = AppEmployeesService();
//                                                       Map<String, int>? employeeCount = await aas3.getSupervisorsAndCustomerServiceEmployees(auth.user.id);

//                                             if (employeeCount != null) {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) {
//                                                     return ManagerStatisticScreen(employeeCount: employeeCount,);
//                                                   },
//                                                 ),
//                                               );
//                                             }
//                                             // Example: Fetch another set of data or navigate to a different screen
//                                           },
//                                           child: Text('statistic'),
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
//                                           child: Text('activate'),
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
//                                           child: Text('employees information'),
//                                         ),
//                             ),

//                           ListTile(
//                               leading:const Icon(Icons.logout),
//                               title:const Text("logout"),
//                               onTap: (){
//                                 Provider.of<Auth>(context,listen: false)
//                                   ..logout();
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
import '../customer_service/customer_service_main_screen.dart'; // Import your Auth class

class ManagerMainScreen extends StatefulWidget {
  const ManagerMainScreen({super.key});

  @override
  State<ManagerMainScreen> createState() => _ManagerMainScreenState();
}

class _ManagerMainScreenState extends State<ManagerMainScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('manager'),
        // backgroundColor: Colors.blueAccent,
        // backgroundColor :Color.fromARGB(255, 56,140,214),
        backgroundColor :Color.fromARGB(255, 56,140,214),
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
      child:Container(
        decoration: const BoxDecoration(  
      //  color: Color.fromARGB(255, 127, 181, 212), // Set your desired background color here  
      color: Color.fromARGB(255, 195, 198, 201), // Set your desired background color here
         ),  
      
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
              ),
            ],
          );
        } else {
          String image = auth.user.image;
          print(image);
          return ListView(
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: DrawerHeader(
                        decoration: const BoxDecoration(
                          // color: Color.fromARGB(255, 148, 158, 167),
                          // color: Color.fromARGB(255, 58, 140, 214), // Set your desired background color here
                          color: Color.fromARGB(255, 58, 140, 214), // Set your desired background color here
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              // backgroundImage: AssetImage(
                              //     'assets/images/clothes-background.jpg'),
                               backgroundImage: AssetImage(image),
                              //NetworkImage(auth.user.image??''),
                              //  backgroundColor: Colors.blue,
                              radius: 35,
                            ),
                            const SizedBox(height: 10),
                            Text(auth.user.name,
                                style: const TextStyle(color: Colors.black)),
                            // const SizedBox(height: 2),
                            Text(auth.user.email,
                                style: const TextStyle(color: Colors.black)),
                          ],
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
    ));
  }

  List<Widget> _buildDrawerItems(Auth auth, BuildContext context) {
    return [
      ListTile(
        leading: const Icon(Icons.person),
        title: const Text('Profile'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserProfile()),
          );
        },
        tileColor: const Color.fromARGB(255, 227, 10, 25), // Set the background color for the ListTile  
      ),
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text('Main Screen'),
        onTap: () async {
          print('ManagerMainScreen');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ManagerMainScreen()),
          );
        },
        tileColor: Colors.blue[100], // Set the background color for the ListTile  
      ),
      ListTile(
        // leading: Icon(Icons.interests),
        leading: const Icon(Icons.fiber_smart_record_rounded),
        title: const Text('Points'),
        onTap: () async {
          print('points');
          AppPointsService aas = AppPointsService();
          List<PointModel?>? points = await aas.GetEmployeePoint(auth.user.id);
          print("middle done");

          if (points != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ShowAllPointsScreen(points: points);
                },
              ),
            );
          }
        },
        tileColor: Colors.blue[100], // Set the background color for the ListTile  
      ),
      // ListTile(
      //   leading: const Icon(Icons.notifications),
      //   title: const Text('Notifications'),
      //   onTap: () async {
      //     AppEmployeesService acp = AppEmployeesService();
      //     List<EmployeeModel?>? employees =
      //         await acp.GetMyAtivateEmployee(auth.user.id);
      //     print(employees);

      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) {
      //           return showActivateEmployees(employees: employees);
      //         },
      //       ),
      //     );
      //   },
      //   tileColor: Colors.blue[100], // Set the background color for the ListTile  
      // ),
      ListTile(
        leading: const Icon(Icons.pie_chart),
        title: const Text('Statistics'),
        onTap: () async {
          AppEmployeesService acp = AppEmployeesService();
          Map<String, int>? employeeCount =
              await acp.getSupervisorsAndCustomerServiceEmployees(auth.user.id);
          print("employees");
          print(employeeCount);

          if (employeeCount != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ManagerStatisticScreen(employeeCount: employeeCount);
              },
            ),
          );
          }
        },
        tileColor: Colors.blue[100], // Set the background color for the ListTile  
      ),
      // ListTile(
      //   leading: const Icon(Icons.logout),
      //   title: const Text("Logout"),
      //   onTap: () {
      //     Provider.of<Auth>(context, listen: false).logout();
      //     Navigator.pushReplacementNamed(context, 'LoginScreen');
      //   },
      //   tileColor: Colors.blue[100], // Set the background color for the ListTile  
      // ),

      ListTile(
        leading: const Icon(Icons.people_alt),
        title: const Text('employees'),
        onTap: () async {
          AppEmployeesService acp = AppEmployeesService();
              List<EmployeeModel?>? employees =
                  await acp.GetMyEmployeesEnformation(auth.user.id);

          if (employees != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return showEmployeesByManages(
                  employees: employees,
                );
              }),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Failed to load employees. Please try again later.')),
            );
          }
        },
        tileColor: Colors.blue[100], // Set the background color for the ListTile  
      ),

      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text("Logout"),
        onTap: () {
          Provider.of<Auth>(context, listen: false).logout();
          Navigator.pushReplacementNamed(context, 'LoginScreen');
        },
        tileColor: Colors.blue[100], // Set the background color for the ListTile  
      ),


    ];
  }

  Widget _buildBody(Auth auth, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          Text(
            'Name: ${auth.user.name}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Email: ${auth.user.email}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Role: ${auth.user.role}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     minimumSize: const Size(200, 50),
          //     backgroundColor: Colors.blueAccent,
          //   ),
          //   onPressed: () async {
          //     AppEmployeesService acp = AppEmployeesService();
          //     List<EmployeeModel?>? employees =
          //         await acp.GetMyEmployeesEnformation(auth.user.id);
          //     if (employees != null) {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) {
          //             return showEmployeesByManages(employees: employees);
          //           },
          //         ),
          //       );
          //     }
          //   },
          //   child: const Text(
          //     'Show Employees by Managers',
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
          // const SizedBox(height: 5),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     minimumSize: const Size(200, 50),
          //     backgroundColor: Colors.blueAccent,
          //   ),
          //   onPressed: () async {
          //     AppPointsService aas = AppPointsService();
          //     AppEmployeesService aas3 = AppEmployeesService();
          //     List<EmployeeModel?>? employeeCount = await aas3
          //         .GetMyEmployeesEnformation(auth.user.id);

          //     if (employeeCount != null) {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) {
          //             return showEmployeesByManages(
          //               employees: employeeCount,
          //             );
          //           },
          //         ),
          //       );
          //     }
          //   },
          //   child: const Text(
          //     'stattistic',
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
        ],
      ),
    );
  }
}
