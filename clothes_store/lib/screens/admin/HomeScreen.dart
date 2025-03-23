// import 'package:clothes_store/models/branch_model.dart';
// import 'package:clothes_store/models/company_model.dart';
// import 'package:clothes_store/models/employee_model.dart';
// import 'package:clothes_store/models/point_model.dart';
// import 'package:clothes_store/models/user.dart';
// import 'package:clothes_store/screens/admin/add_admin_screen.dart';
// import 'package:clothes_store/screens/admin/add_company_screen.dart';
// import 'package:clothes_store/screens/admin/add_employee_screen.dart';
// import 'package:clothes_store/screens/admin/add_new_screen.dart';
// import 'package:clothes_store/screens/admin/show_user_screen.dart';
// import 'package:clothes_store/screens/shared_screen/login_screen.dart';
// import 'package:clothes_store/screens/admin/show_all_branches_screen.dart';
// import 'package:clothes_store/screens/admin/show_all_employees.dart';
// import 'package:clothes_store/screens/admin/show_all_points_screen.dart';
// import 'package:clothes_store/screens/admin/statistics_screen.dart';
// import 'package:clothes_store/screens/shared_screen/user_profile_screen.dart';
// import 'package:clothes_store/services/branch_services.dart';
// import 'package:clothes_store/services/company_services.dart';
// import 'package:clothes_store/services/employee_services.dart';
// import 'package:clothes_store/services/point_services.dart';
// import 'package:clothes_store/services/user_services.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:clothes_store/services/auth.dart';

// import '../../models/accessory_model.dart';
// import 'package:clothes_store/screens/shared_screen/MainScreen.dart';

// import '../../services/accessory_services.dart';
// import '../../services/auth_remastered.dart';
// import 'add_accessory_screen.dart';
// import 'show_all_accessories_screen.dart';
// import 'show_all_companies_screen.dart';
// import 'update_company_screen.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('admin main screen'),
//           backgroundColor: Colors.blueAccent,
//         shadowColor: Colors.black,
//         elevation: 2,
//         automaticallyImplyLeading: MediaQuery.of(context).size.width <= 600,
//       ),

//       drawer: Drawer(
//                           child:Consumer<Auth>(builder:(context,auth,child){
//                             // if (!  auth!.authenticated){
//                             if (  !auth.authenticated){
//                               return ListView(
//                                 children: [
//                                   ListTile(
//                               leading:const Icon(Icons.login),
//                               title:const Text("loginn"),
//                               onTap: (){
//                                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
//                               },
//                               )],
//                             );
//                             // );

//                             }
//                             else{
//                           return ListView(children: [

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

//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (context) {
//                                                     return AddNewScreen();
//                                                   },
//                                                 ),
//                                               );
//                                             // Example: Fetch another set of data or navigate to a different screen
//                                           },
//                                           child: Text('add new'),
//                                         ),
//                             ),

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

//                             ListTile(
//                               title:ElevatedButton(
//                                           onPressed: () async {
//                                             // Your new button functionality goes here
//                                             print('statistic');

//                                               AppPointsService aas = AppPointsService();
//                                               List<PointModel?>? points = await aas.GetAllPoint();
//                                               AppBranchesService ass2= AppBranchesService();
//                                               int? branchesCount = await ass2.getBranchesCount() ?? 0;
//                                               AppEmployeesService aas3 = AppEmployeesService();
//                                                 Map<String, int>? employeeCount = await aas3.getEmployeesCount();
//                                                 print(branchesCount);
//                                                 print(employeeCount);

//                                               if (points != null && employeeCount != null) {
//                                                 List<int> pointsCount = points.map((points) => points!.points_count).toList();
//                                                 print(pointsCount);
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(builder: (context) {
//                                                     return statistics_screen(
//                                                       points: pointsCount,
//                                                       branchesCount: branchesCount,
//                                                       employeeCount :  employeeCount ,
//                                                     );
//                                                   }),
//                                                 );
//                                               } else {
//                                                 ScaffoldMessenger.of(context).showSnackBar(
//                                                   SnackBar(content: Text('Failed to load employees. Please try again later.')),
//                                                 );
//                                               }
//                                             // Example: Fetch another set of data or navigate to a different screen
//                                           },
//                                           child: Text('statistic'),
//                                         ),
//                             ),

//                             ListTile(
//                               title:ElevatedButton(
//                                           onPressed: () async {
//                                             // Your new button functionality goes here
//                                             AppEmployeesService aas = AppEmployeesService();
//                                               List<EmployeeModel?>? employees = await aas.GetAllEmployees();

//                                               if (employees != null) {
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(builder: (context) {
//                                                     return ShowAllEmployeesScreen(
//                                                       employees: employees,
//                                                     );
//                                                   }),
//                                                 );
//                                               } else {
//                                                 ScaffoldMessenger.of(context).showSnackBar(
//                                                   SnackBar(content: Text('Failed to load employees. Please try again later.')),
//                                                 );
//                                               }

//                                           },
//                                           child: Text('employees'),
//                                         ),
//                                      ),

//                             ListTile(
//                               title:ElevatedButton(
//                                           onPressed: () async {
//                                             // Your new button functionality goes here
//                                             AppBranchesService aas = AppBranchesService();
//                                             print("ssssssssssssss");
//                                               List<BranchModel?>? branches = await aas.GetAllBranches();
//                                               print("ssssss32222222222");
//                                               print(branches);

//                                               if (branches != null) {
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(builder: (context) {
//                                                     return ShowAllBranchesScreen(
//                                                       branches: branches,
//                                                     );
//                                                   }),
//                                                 );
//                                               } else {
//                                                 ScaffoldMessenger.of(context).showSnackBar(
//                                                   SnackBar(content: Text('Failed to load employees. Please try again later.')),
//                                                 );
//                                               }

//                                           },
//                                           child: Text('bracnhes'),
//                                         ),
//                              ),

//                              ListTile(
//                               title:ElevatedButton(
//                                           onPressed: () async {
//                                                               AppPointsService aas = AppPointsService();
//                                           List<PointModel?>? points = await aas.GetAllPoint();

//                                           if (points != null) {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(builder: (context) {
//                                                 return ShowAllPointsScreen(
//                                                   points: points,
//                                                 );
//                                               }),
//                                             );
//                                           } else {
//                                             ScaffoldMessenger.of(context).showSnackBar(
//                                               SnackBar(content: Text('Failed to load employees. Please try again later.')),
//                                             );
//                                           }

//                                           },
//                                           child: Text('points'),
//                                         ),
//                              ),

//                              ListTile(
//                               title:ElevatedButton(
//                                           onPressed: () async {
//                                             // Navigating to About Us page
//                                              Navigator.of(context).pushNamed('home');

//                                           },
//                                           child: Text('home'),
//                                         ),
//                              ),

//                              ListTile(
//                               title:ElevatedButton(
//                                           onPressed: () async {
//                                             // Your new button functionality goes here
//                                             AppUsersService aas = AppUsersService();
//                                             print("users1");
//                                               List<UserModel?>? users = await aas.GetAllUsers();
//                                               print("user2");
//                                               print(users);

//                                               if (users != null) {
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(builder: (context) {
//                                                     return ShowAllUsersScreen(
//                                                       users: users,
//                                                     );
//                                                   }),
//                                                 );
//                                               } else {
//                                                 ScaffoldMessenger.of(context).showSnackBar(
//                                                   SnackBar(content: Text('Failed to load employees. Please try again later.')),
//                                                 );
//                                               }

//                                           },
//                                           child: Text('users'),
//                                         ),
//                              ),

//                           ListTile(
//                               leading:const Icon(Icons.logout),
//                               title:const Text("logout"),
//                               onTap: (){
//                                 Provider.of<Auth>(context,listen: false)
//                                   ..logout();
//                                   Navigator.pushReplacementNamed(context, 'mainscreen');
//                               },
//                             ),

//                           ],
//                           );
//                             }
//                       })
//                       ),

//       // );
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             DropdownButton<String>(
//               hint: Text('Select'),
//               items: <String>[
//                 'Show All Companies',
//                 'Add New Company',
//                 'Show All Accessories',
//                 // 'Add New Accessory',
//                 'Show All Employees',
//                 'Add New Employee',
//                 'Add New Admin',
//                 'Show All Points',
//                 'statistics'
//               ].map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (String? newValue) async {
//                 if (newValue != null) {
//                   switch (newValue) {
//                     case 'Show All Companies':
//                       AppCompaniesService acp = AppCompaniesService();
//                       List<CompanyModel?>? companies =
//                           await acp.GetAllCompanies();
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) {
//                           return ShowAllCompaniesScreen(
//                             companies: companies,
//                           );
//                         }),
//                       );
//                       break;
//                     case 'Add New Company':
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) {
//                           return AddCompanyScreen();
//                         }),
//                       );
//                       break;
//                     case 'Show All Accessories':
//                       AppAccessoriesService aas = new AppAccessoriesService();
//                       List<AccessoryModel?>? accessories =
//                           await aas.GetAllAccessories();
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) {
//                           return ShowAllAccessoriesScreen(
//                             accessories: accessories,
//                           );
//                         }),
//                       );
//                       break;

//                         case 'Show All Employees':
//                         AppEmployeesService aas = AppEmployeesService();
//                         List<EmployeeModel?>? employees = await aas.GetAllEmployees();

//                         if (employees != null) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) {
//                               return ShowAllEmployeesScreen(
//                                 employees: employees,
//                               );
//                             }),
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Failed to load employees. Please try again later.')),
//                           );
//                         }
//                         break;

//                     case 'Add New Employee':
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) {
//                           return AddEmployeeScreen();
//                         }),
//                       );
//                       break;

//                       case 'Add New Admin':
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) {
//                           return AddAdminScreen();
//                         }),
//                       );
//                       break;

//                     case 'Show All Points':
//                         AppPointsService aas = AppPointsService();
//                         List<PointModel?>? points = await aas.GetAllPoint();

//                         if (points != null) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) {
//                               return ShowAllPointsScreen(
//                                 points: points,
//                               );
//                             }),
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Failed to load employees. Please try again later.')),
//                           );
//                         }
//                         break;

//                         case 'statistics':
//                         AppPointsService aas = AppPointsService();
//                         List<PointModel?>? points = await aas.GetAllPoint();
//                         AppBranchesService ass2= AppBranchesService();
//                         int? branchesCount = await ass2.getBranchesCount() ?? 0;
//                         AppEmployeesService aas3 = AppEmployeesService();
//                           Map<String, int>? employeeCount = await aas3.getEmployeesCount();
//                           print(branchesCount);
//                           print(employeeCount);

//                         if (points != null && employeeCount != null) {
//                           List<int> pointsCount = points.map((points) => points!.points_count).toList();
//                           print(pointsCount);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) {
//                               return statistics_screen(
//                                 points: pointsCount,
//                                 branchesCount: branchesCount,
//                                 employeeCount :  employeeCount ,
//                               );
//                             }),
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Failed to load employees. Please try again later.')),
//                           );
//                         }
//                         break;
//                   }
//                 }
//               },
//             ),
//              Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: MaterialButton(
//               color: Colors.red,
//               textColor: Colors.white,
//               onPressed: () {
//                 // Navigating to About Us page
//                 Navigator.of(context).pushNamed('mainscreen');
//               },
//               child: const Text("Go to About Us by pushReplacementNamed"),
//             ),
//           ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:clothes_store/constants.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/models/evaluation_model.dart';
import 'package:clothes_store/models/point_model.dart';
import 'package:clothes_store/screens/customer_service/customer_service_points.dart';
import 'package:clothes_store/screens/shared_screen/evaluation/evaluation_screen.dart';
import 'package:clothes_store/screens/shared_screen/login_screen.dart';
import 'package:clothes_store/screens/manager/activate_employee_screen.dart';
import 'package:clothes_store/screens/manager/manager_statistics_screen.dart';
import 'package:clothes_store/screens/manager/show_all_managers_employees.dart';
import 'package:clothes_store/screens/admin/show_all_companies_screen.dart';
import 'package:clothes_store/screens/shared_screen/user_profile_screen.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:clothes_store/services/company_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:clothes_store/services/evaluation_service.dart';
import 'package:clothes_store/services/point_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clothes_store/services/auth.dart';
import '../../models/accessory_model.dart';
import '../../models/branch_model.dart';
import '../../models/user.dart';
import '../../services/accessory_services.dart';
import '../../services/auth_remastered.dart';
import '../../services/user_services.dart';
import '../customer_service/customer_service_main_screen.dart';
import 'AddCompanyScreen.dart';
import 'add_admin_screen.dart';
import 'add_company_screen.dart';
import 'add_employee_screen.dart';
import 'show_all_accessories_screen.dart';
import 'show_all_branches_screen.dart';
import 'show_all_employees.dart';
import 'show_all_points_screen.dart';
import 'show_user_screen.dart';
import 'statistics_screen.dart'; // Import your Auth class

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
 
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home Screen'),
      //   // backgroundColor: const Color.fromARGB(255, 80, 139, 241),
      //   backgroundColor :Color.fromARGB(255, 56, 140, 214), // Set your desired background color here   // Set your desired background color here  
      //   shadowColor: Colors.black,
      //   elevation: 2,
      //   automaticallyImplyLeading: MediaQuery.of(context).size.width <= 600,
      //   actions: [
      //       // Add the DropdownButton here
      //       Padding(
      //         padding: const EdgeInsets.only(right: 10),
      //         child: DropdownButton<String>(
      //         hint: const Text('show'),
      //         items: <String>[
                            
      //           'Companies',
                           
                
      //           'Accessories',
      //           'Employees',
              
      //           'Points'
      //         ].map((String value) {
      //           return DropdownMenuItem<String>(
      //             value: value,
      //             child: Text(value),
      //           );
      //         }).toList(),
      //         onChanged: (String? newValue) async {
      //           if (newValue != null) {
      //             switch (newValue) {
      //               case 'Show All Companies':
      //                  AppCompaniesService acp = AppCompaniesService();
      //               List<CompanyModel?>? companies =
      //                   await acp.GetAllCompanies();
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(builder: (context) {
      //                   return ShowAllCompaniesScreen(
      //                     companies: companies,
      //                   );
      //                 }),
      //               );
      //                 break;
      //               case 'Show All Accessories':
      //                  AppAccessoriesService aas = AppAccessoriesService();
      //               List<AccessoryModel?>? accessories =
      //                   await aas.GetAllAccessories();
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(builder: (context) {
      //                   return ShowAllAccessoriesScreen(
      //                     accessories: accessories,
      //                   );
      //                 }),
      //               );
      //                 break;
      //               case 'Show All Employees':
      //                   AppEmployeesService aas = AppEmployeesService();
      //                 List<EmployeeModel?>? employees =
      //                     await aas.GetAllEmployees();
                            
      //                 if (employees != null) {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(builder: (context) {
      //                       return ShowAllEmployeesScreen(
      //                         employees: employees,
      //                       );
      //                     }),
      //                   );
      //                 } else {
      //                   ScaffoldMessenger.of(context).showSnackBar(
      //                     const SnackBar(
      //                         content: Text(
      //                             'Failed to load employees. Please try again later.')),
      //                   );
      //                 }
      //                 break;
      //               case 'Show All Points':
      //                  AppPointsService aas = AppPointsService();
      //               List<PointModel?>? points = await aas.GetAllPoint();
              
      //               if (points != null) {
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) {
      //                     return ShowAllPointsScreen(
      //                       points: points,
      //                     );
      //                   }),
      //                 );
      //               } else {
      //                 ScaffoldMessenger.of(context).showSnackBar(
      //                   const SnackBar(
      //                       content: Text(
      //                           'Failed to load employees. Please try again later.')),
      //                 );
      //               }
      //                 break;
      //             }
      //           }
      //         },
      //                       ),
      //       ),
      //                      Padding(
      //                        padding: const EdgeInsets.only(right: 10.0),
      //                        child: DropdownButton<String>(
      //                                    hint: const Text('add new'),
      //                                    items: <String>[
      //                                      'Company',
      //                                      'Employee',
      //                                      'Admin',
      //                                      'statistics'
      //                                    ].map((String value) {
      //                                      return DropdownMenuItem<String>(
      //                                        value: value,
      //                                        child: Text(value),
      //                                      );
      //                                    }).toList(),
      //                                    onChanged: (String? newValue) async {
      //                                      if (newValue != null) {
      //                                        switch (newValue) {
      //                                          case 'Add New Company':
      //                                            Navigator.push(
      //                                            context,
      //                                            MaterialPageRoute(builder: (context) {
      //                                              return AddCompanyScreen();
      //                                            }),
      //                                          );
      //                                            break;
      //                                          case 'Add New Employee':
      //                                              Navigator.push(
      //                                            context,
      //                                            MaterialPageRoute(builder: (context) {
      //                                              return AddEmployeeScreen();
      //                                            }),
      //                                          );
      //                                            break;
      //                                          case 'Add New Admin':
      //                                             Navigator.push(
      //                                            context,
      //                                            MaterialPageRoute(builder: (context) {
      //                                              return AddAdminScreen();
      //                                            }),
      //                                          );
      //                                            break;
      //                                          case 'statistics':
      //                                            AppPointsService aas = AppPointsService();
      //                                          List<PointModel?>? points = await aas.GetAllPoint();
      //                                          AppBranchesService ass2 = AppBranchesService();
      //                                          int? branchesCount = await ass2.getBranchesCount() ?? 0;
      //                                          AppEmployeesService aas3 = AppEmployeesService();
      //                                          Map<String, int>? employeeCount =
      //                                              await aas3.getEmployeesCount();
      //                                          print(branchesCount);
      //                                          print(employeeCount);
                                         
      //                                          if (points != null && employeeCount != null) {
      //                                            List<int> pointsCount = points
      //                                                .map((points) => points!.points_count)
      //                                                .toList();
      //                                            print(pointsCount);
      //                                            Navigator.push(
      //                                              context,
      //                                              MaterialPageRoute(builder: (context) {
      //                                                return statistics_screen(
      //                                                  points: pointsCount,
      //                                                  branchesCount: branchesCount,
      //                                                  employeeCount: employeeCount,
      //                                                );
      //                                              }),
      //                                            );
      //                                          } else {
      //                                            ScaffoldMessenger.of(context).showSnackBar(
      //                                              const SnackBar(
      //                                                  content: Text(
      //                           'Failed to load employees. Please try again later.')),
      //                                            );
      //                                          }
      //                                            break;
      //                                        }
      //                                      }
      //                                    },
      //                                                  ),
      //                      ),

      //                      Padding(
      //                        padding: const EdgeInsets.only(right: 10.0),
      //                        child: DropdownButton<String>(
      //                                    hint: const Text('evaluation'),
      //                                    items: <String>[
      //                                      'daily',
      //                                      'weekly',
      //                                      'monthly',
      //                                    ].map((String value) {
      //                                      return DropdownMenuItem<String>(
      //                                        value: value,
      //                                        child: Text(value),
      //                                      );
      //                                    }).toList(),
      //                                    onChanged: (String? newValue) async {
      //                                      if (newValue != null) {
      //                                        switch (newValue) {
      //                                          case 'daily':
      //                                            AppEvaluationService aas = AppEvaluationService();
      //                                          List<EvaluationModel?>? evaluation = await aas.GetDailyEvaluation();
                                                                                       
      //                                          if (evaluation != null || evaluation != null) {
                                                
      //                                            Navigator.push(
      //                                              context,
      //                                              MaterialPageRoute(builder: (context) {
      //                                                return ShowEvaluationScreen(
      //                                                  evaluations: evaluation,
                                                       
      //                                                );
      //                                              }),
      //                                            );
      //                                          } 
      //                                          else {
      //                                            ScaffoldMessenger.of(context).showSnackBar(
      //                                              const SnackBar(
      //                                                  content: Text(
      //                           'Failed to load employees. Please try again later.')),
      //                                            );
      //                                          }
      //                                            break;


      //                                          case 'weekly':
      //                                            AppEvaluationService aas = AppEvaluationService();
      //                                          List<EvaluationModel?>? evaluation = await aas.GetWeeklyEvaluation();
                                                                                       
      //                                          if (evaluation != null || evaluation != null) {
      //                                           //  List<int> pointsCount = points
      //                                           //      .map((points) => points!.points_count)
      //                                           //      .toList();
      //                                           //  print(pointsCount);
      //                                            Navigator.push(
      //                                              context,
      //                                              MaterialPageRoute(builder: (context) {
      //                                                return ShowEvaluationScreen(
      //                                                  evaluations: evaluation,
                                                       
      //                                                );
      //                                              }),
      //                                            );
      //                                          } 
      //                                          else {
      //                                            ScaffoldMessenger.of(context).showSnackBar(
      //                                              const SnackBar(
      //                                                  content: Text(
      //                           'Failed to load employees. Please try again later.')),
      //                                            );
      //                                          }
      //                                            break;

      //                                          case 'monthly':
      //                                            AppEvaluationService aas = AppEvaluationService();
      //                                          List<EvaluationModel?>? evaluation = await aas.GetmonthlyEvaluation();
                                                                                       
      //                                          if (evaluation != null || evaluation != null) {
      //                                           //  List<int> pointsCount = points
      //                                           //      .map((points) => points!.points_count)
      //                                           //      .toList();
      //                                           //  print(pointsCount);
      //                                            Navigator.push(
      //                                              context,
      //                                              MaterialPageRoute(builder: (context) {
      //                                                return ShowEvaluationScreen(
      //                                                  evaluations: evaluation,
                                                       
      //                                                );
      //                                              }),
      //                                            );
      //                                          } 
      //                                          else {
      //                                            ScaffoldMessenger.of(context).showSnackBar(
      //                                              const SnackBar(
      //                                                  content: Text(
      //                             'Failed to load employees. Please try again later.')),
      //                                            );
      //                                          }
      //                                            break;

                                               
      //                                        }
      //                                      }
      //                                    },
      //                                                  ),
      //                      ),
      //     ],
      // ),


      appBar: AppBar(  
        // backgroundColor: Color.fromARGB(255, 56, 140, 214), // Desired background color  
        backgroundColor: Color.fromARGB(255, 56, 140, 214), // Desired background color  
        shadowColor: Colors.black,  
        elevation: 2,  
        automaticallyImplyLeading: MediaQuery.of(context).size.width <= 600,  
        title: Row(  
          mainAxisAlignment: MainAxisAlignment.start, // Align to the start (left)  
          children: [  
            const Text(  
              'Home Screen',  
              textAlign: TextAlign.left, // Align text to the left  
            ),  
            const SizedBox(width: 10), // Add some space after title  
            // This is where you can add your lines  
            // Container(  
            //   height: 1,  // Height of the line  
            //   width: MediaQuery.of(context).size.width * 0.45, // Line width, adjust as necessary  
            //   color: Colors.white, // Line color  
            // ),  
          ],  
        ),  
        actions: [  
          // Your Dropdown for "Show"  
          Padding(  
            padding: const EdgeInsets.only(right: 10.0),  
            child: DropdownButton<String>(  
              hint: const Text('Show'),  
              items: <String>[  
                'Show All Companies',  
                'Show All Accessories',  
                'Show All Employees',  
                'Show All Points'  
              ].map((String value) {  
                return DropdownMenuItem<String>(  
                  value: value,  
                  child: Text(value),  
                );  
              }).toList(),  
              onChanged: (String? newValue) async {  
                if (newValue != null) {  
                  // Action handling for dropdown  
                  switch (newValue) {  
                    case 'Show All Companies':  
                      AppCompaniesService acp = AppCompaniesService();  
                      List<CompanyModel?>? companies = await acp.GetAllCompanies();  
                      Navigator.push(  
                        context,  
                        MaterialPageRoute(  
                          builder: (context) {  
                            return ShowAllCompaniesScreen(  
                              companies: companies,  
                            );  
                          },  
                        ),  
                      );  
                      break;  
                    case 'Show All Accessories':  
                      AppAccessoriesService aas = AppAccessoriesService();  
                      List<AccessoryModel?>? accessories = await aas.GetAllAccessories();  
                      Navigator.push(  
                        context,  
                        MaterialPageRoute(  
                          builder: (context) {  
                            return ShowAllAccessoriesScreen(accessories: accessories);  
                          },  
                        ),  
                      );  
                      break;  
                    case 'Show All Employees':  
                      AppEmployeesService aasEmployees = AppEmployeesService();  
                      List<EmployeeModel?>? employees = await aasEmployees.GetAllEmployees();  
                      if (employees != null) {  
                        Navigator.push(  
                          context,  
                          MaterialPageRoute(  
                            builder: (context) {  
                              return ShowAllEmployeesScreen(employees: employees);  
                            },  
                          ),  
                        );  
                      } else {  
                        ScaffoldMessenger.of(context).showSnackBar(  
                          const SnackBar(content: Text('Failed to load employees. Please try again later.')),  
                        );  
                      }  
                      break;  
                    case 'Show All Points':  
                      AppPointsService aasPoints = AppPointsService();  
                      List<PointModel?>? points = await aasPoints.GetAllPoint();  
                      if (points != null) {  
                        Navigator.push(  
                          context,  
                          MaterialPageRoute(  
                            builder: (context) {  
                              return ShowAllPointsScreen(points: points);  
                            },  
                          ),  
                        );  
                      } else {  
                        ScaffoldMessenger.of(context).showSnackBar(  
                          const SnackBar(content: Text('Failed to load points. Please try again later.')),  
                        );  
                      }  
                      break;  
                  }  
                }  
              },  
            ),  
          ),  
          // Dropdown for "Add New"  
          Padding(  
            padding: const EdgeInsets.only(right: 10.0),  
            child: DropdownButton<String>(  
              hint: const Text('Add New'),  
              items: <String>[  
                'Add New Company',  
                'Add New Employee',  
                'Add New Admin',  
                'Statistics'  
              ].map((String value) {  
                return DropdownMenuItem<String>(  
                  value: value,  
                  child: Text(value),  
                );  
              }).toList(),  
              onChanged: (String? newValue) async {  
                if (newValue != null) {  
                  switch (newValue) {  
                    case 'Add New Company':  
                      Navigator.push(  
                        context,  
                        MaterialPageRoute(builder: (context) {  
                          return AddCompanyScreen();  
                        }),  
                      );  
                      break;  
                    case 'Add New Employee':  
                      Navigator.push(  
                        context,  
                        MaterialPageRoute(builder: (context) {  
                          return AddEmployeeScreen();  
                        }),  
                      );  
                      break;  
                    case 'Add New Admin':  
                      Navigator.push(  
                        context,  
                        MaterialPageRoute(builder: (context) {  
                          return AddAdminScreen();  
                        }),  
                      );  
                      break;  
                    // case 'Statistics':  
                    //   AppPointsService aas = AppPointsService();  
                    //   List<PointModel?>? points = await aas.GetAllPoint();  
                    //   AppBranchesService ass2 = AppBranchesService();  
                    //   int? branchesCount = await ass2.getBranchesCount() ?? 0;  
                    //   AppEmployeesService aas3 = AppEmployeesService();  
                    //   Map<String, int>? employeeCount = await aas3.getEmployeesCount();  
                    //   if (points != null && employeeCount != null) {  
                    //     List<int> pointsCount = points.map((point) => point!.points_count).toList();  
                    //     Navigator.push(  
                    //       context,  
                    //       MaterialPageRoute(builder: (context) {  
                    //         return StatisticsScreen(  
                    //           points: pointsCount,  
                    //           branchesCount: branchesCount,  
                    //           employeeCount: employeeCount,  
                    //         );  
                    //       }),  
                    //     );  
                    //   } else {  
                    //     ScaffoldMessenger.of(context).showSnackBar(  
                    //       const SnackBar(content: Text('Failed to load statistics. Please try again later.')),  
                    //     );  
                    //   }  
                    //   break;  
                  }  
                }  
              },  
            ),  
          ),  
          // Dropdown for evaluations  
          Padding(  
            padding: const EdgeInsets.only(right: 10.0),  
            child: DropdownButton<String>(  
              hint: const Text('Evaluation'),  
              items: <String>[  
                'Daily',  
                'Weekly',  
                'Monthly',  
              ].map((String value) {  
                return DropdownMenuItem<String>(  
                  value: value,  
                  child: Text(value),  
                );  
              }).toList(),  
              onChanged: (String? newValue) async {  
                if (newValue != null) {  
                  AppEvaluationService aas = AppEvaluationService();  
                  List<EvaluationModel?>? evaluation;  

                  switch (newValue) {  
                    case 'Daily':  
                      evaluation = await aas.GetDailyEvaluation();  
                      break;  
                    case 'Weekly':  
                      evaluation = await aas.GetWeeklyEvaluation();  
                      break;  
                    case 'Monthly':  
                      evaluation = await aas.GetmonthlyEvaluation();  
                      break;  
                  }  
                  if (evaluation != null) {  
                    Navigator.push(  
                      context,  
                      MaterialPageRoute(builder: (context) {  
                        return ShowEvaluationScreen(evaluations: evaluation);  
                      }),  
                    );  
                  } else {  
                    ScaffoldMessenger.of(context).showSnackBar(  
                      const SnackBar(content: Text('Failed to load evaluations. Please try again later.')),  
                    );  
                  }  
                }  
              },  
            ),  
          ),  

          // Dropdown for evaluations  
          Padding(  
            padding: const EdgeInsets.only(right: 10.0),  
            child: DropdownButton<String>(  
              hint: const Text('Evaluate'),  
              items: <String>[  
                'Daily Evaluate',  
                'Weekly Evaluate',  
                'Monthly Evaluate',  
              ].map((String value) {  
                return DropdownMenuItem<String>(  
                  value: value,  
                  child: Text(value),  
                );  
              }).toList(),  
              onChanged: (String? newValue) async {  
                if (newValue != null) {  
                  AppEvaluationService aas = AppEvaluationService();  
                  List<EvaluationModel?>? evaluation;  

                  switch (newValue) {  
                    case 'Daily Evaluate':  
                      evaluation = await aas.Evaluate_employee_daily();  
                      break;  
                    case 'Weekly Evaluate':  
                      evaluation = await aas.Evaluate_employee();  
                      break;  
                    case 'Monthly Evaluate':  
                      evaluation = await aas.Evaluate_employee_monthly();  
                      break;  
                  }  
                  if (evaluation != null) {  
                    Navigator.push(  
                      context,  
                      MaterialPageRoute(builder: (context) {  
                        return ShowEvaluationScreen(evaluations: evaluation);  
                      }),  
                    );  
                  } else {  
                    ScaffoldMessenger.of(context).showSnackBar(  
                      const SnackBar(content: Text('Failed to load evaluations. Please try again later.')),  
                    );  
                  }  
                }  
              },  
            ),  
          ),  

        ],  
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
       color: Color.fromARGB(255, 195, 198, 201), // Set your desired background color here  
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
     //     print(auth.user.image);
       //  String userImage = "$path$image";  
       //  print(userImage);
          print(image);
          return ListView(
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: DrawerHeader(
                        decoration: const BoxDecoration(
                          // color: Color.fromARGB(255, 11, 60, 100),
                         color: Color.fromARGB(255, 58, 140, 214), // Set your desired background color here  
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(image),
                             
                              //NetworkImage(auth.user.image??''),
                              //  backgroundColor: Colors.blue,
                              radius: 35,
                             // child: Image.network(userImage),
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
        leading: const Icon(Icons.person_3,color: Color.fromARGB(255, 107, 138, 215),),
        title: const Text('profile'),
        onTap: () {
          print('profile');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return UserProfile();
              },
            ),
          );
        },
        tileColor: const Color.fromARGB(255, 97, 107, 114), // Set the background color for the ListTile  
      ),
      ListTile(
        leading: const Icon(Icons.people_alt,color: Color.fromARGB(255, 107, 138, 215),),
        title: const Text('employees'),
        onTap: () async {
          AppEmployeesService aas = AppEmployeesService();
          List<EmployeeModel?>? employees = await aas.GetAllEmployees();

          if (employees != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ShowAllEmployeesScreen(
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
        leading: const Icon(Icons.score,color: Color.fromARGB(255, 107, 138, 215),),
        title: const Text('evaluate'),
        onTap: () async {
          AppEvaluationService aas = AppEvaluationService();
          List<EvaluationModel?>? evaluated = await aas.Evaluate_employee();
          print("evaluated done");
          print(evaluated);

          // if (employees != null) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) {
          //       return ShowAllEmployeesScreen(
          //         employees: employees,
          //       );
          //     }),
          //   );
          // } else {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //         content: Text(
          //             'Failed to load employees. Please try again later.')),
          //   );
          // }
        },
        tileColor: Colors.blue[100], // Set the background color for the ListTile  
      ),

      ListTile(
        leading: const Icon(Icons.add_chart,color: Color.fromARGB(255, 107, 138, 215),),
        title: const Text('statistic'),
        onTap: () async {
          print('statistic');

          AppPointsService aas = AppPointsService();
          List<PointModel?>? points = await aas.GetAllPoint();
          AppBranchesService ass2 = AppBranchesService();
          int? branchesCount = await ass2.getBranchesCount() ?? 0;
          AppEmployeesService aas3 = AppEmployeesService();
          Map<String, int>? employeeCount = await aas3.getEmployeesCount();
          print(branchesCount);
          print(employeeCount);

          if (points != null && employeeCount != null) {
            List<int> pointsCount =
                points.map((points) => points!.points_count).toList();
            print(pointsCount);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return statistics_screen(
                  points: pointsCount,
                  branchesCount: branchesCount,
                  employeeCount: employeeCount,
                );
              }),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Failed to load statistics. Please try again later.')),
            );
          }
        },
        tileColor: Colors.blue[100], // Set the background color for the ListTile  
      ),
      ListTile(
        leading: const Icon(Icons.other_houses,color: Color.fromARGB(255, 107, 138, 215),),
        title: const Text('branches'),
        onTap: () async {
          AppBranchesService aas = AppBranchesService();
          print("Fetching branches...");
          List<BranchModel?>? branches = await aas.GetAllBranches();
          print("Branches fetched: $branches");

          if (branches != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ShowAllBranchesScreen(
                  branches: branches,
                );
              }),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content:
                      Text('Failed to load branches. Please try again later.')),
            );
          }
        },
        tileColor: Colors.blue[100], // Set the background color for the ListTile  
      ),
      ListTile(
        // leading: const Icon(Icons.pages),
        leading: const Icon(Icons.fiber_smart_record_rounded,color: Color.fromARGB(255, 107, 138, 215),),
        title: const Text('points'),
        onTap: () async {
          AppPointsService aas = AppPointsService();
          List<PointModel?>? points = await aas.GetAllPoint();

          if (points != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ShowAllPointsScreen(
                  points: points,
                );
              }),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content:
                      Text('Failed to load points. Please try again later.')),
            );
          }
        },
        tileColor: Colors.blue[100], // Set the background color for the ListTile  
      ),
      // ListTile(
      //   leading: const Icon(Icons.pages),
      //   title: const Text('points'),
      //   onTap: () async {
      //     AppPointsService aas = AppPointsService();
      //     List<PointModel?>? points = await aas.GetAllPoint();

      //     if (points != null) {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) {
      //           return ShowAllPointsScreen(
      //             points: points,
      //           );
      //         }),
      //       );
      //     } else {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //             content:
      //                 Text('Failed to load points. Please try again later.')),
      //       );
      //     }
      //   },
      //   tileColor: Colors.blue[100], // Set the background color for the ListTile  
      // ),
      ListTile(
        leading: const Icon(Icons.home,color: Color.fromARGB(255, 107, 138, 215),),
        title: const Text('home'),
        onTap: () {
          // Navigating to Home page
          Navigator.of(context).pushNamed('home');
        },
        tileColor: Colors.blue[100], // Set the background color for the ListTile  
      ),
      ListTile(
        leading: const Icon(Icons.people,color: Color.fromARGB(255, 107, 138, 215),),
        title: const Text('users'),
        onTap: () async {
          AppUsersService aas = AppUsersService();
          print("Fetching users...");
          List<UserModel?>? users = await aas.GetAllUsers();
          print("Users fetched: $users");

          if (users != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ShowAllUsersScreen(
                  users: users,
                );
              }),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content:
                      Text('Failed to load users. Please try again later.')),
            );
          }
        },
        tileColor: Colors.blue[100], // Set the background color for the ListTile  
      ),
      ListTile(
        leading: const Icon(Icons.logout,color: Color.fromARGB(255, 107, 138, 215),),
        title: const Text("logout"),
        onTap: () {
          Provider.of<Auth>(context, listen: false).logout();
          Navigator.pushReplacementNamed(context, 'LoginScreen');
        },
        tileColor: Colors.blue[100], // Set the background color for the ListTile  
      ),
    ];
  }

  Widget _buildBody(Auth auth, BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 233, 233),
      body: Center(

        child:Text("real time camera")


      
      // child: Column(
        
        
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
        
      //   children: [
          
      //     Container(
            
      //       decoration: BoxDecoration(
              
              
              
      //         border: Border.all(
      //             color: const Color.fromARGB(255, 0, 0, 0),
      //             width: 1), // Border color and width
      //         borderRadius: BorderRadius.circular(8), // Rounded corners
      //         // color: const Color.fromARGB(255, 196, 111, 111), // Background color
      //       ),
      //       padding: const EdgeInsets.symmetric(
      //           horizontal: 10), // Padding for the dropdown

      //       child: DropdownButton<String>(
      //         hint: const Text('Select'),
      //         items: <String>[
      //           'Show All Companies',
      //           'Add New Company',
      //           'Show All Accessories',
      //           // 'Add New Accessory',
      //           'Show All Employees',
      //           'Add New Employee',
      //           'Add New Admin',
      //           'Show All Points',
      //           'statistics'
      //         ].map((String value) {
      //           return DropdownMenuItem<String>(
      //             value: value,
      //             child: Text(value),
      //           );
      //         }).toList(),
      //         onChanged: (String? newValue) async {
      //           if (newValue != null) {
      //             switch (newValue) {
      //               case 'Show All Companies':
      //                 AppCompaniesService acp = AppCompaniesService();
      //                 List<CompanyModel?>? companies =
      //                     await acp.GetAllCompanies();
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) {
      //                     return ShowAllCompaniesScreen(
      //                       companies: companies,
      //                     );
      //                   }),
      //                 );
      //                 break;
      //               case 'Add New Company':
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) {
      //                     return AddCompanyScreen();
      //                   }),
      //                 );
      //                 break;
      //               case 'Show All Accessories':
      //                 AppAccessoriesService aas = AppAccessoriesService();
      //                 List<AccessoryModel?>? accessories =
      //                     await aas.GetAllAccessories();
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) {
      //                     return ShowAllAccessoriesScreen(
      //                       accessories: accessories,
      //                     );
      //                   }),
      //                 );
      //                 break;

      //               case 'Show All Employees':
      //                 AppEmployeesService aas = AppEmployeesService();
      //                 List<EmployeeModel?>? employees =
      //                     await aas.GetAllEmployees();

      //                 if (employees != null) {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(builder: (context) {
      //                       return ShowAllEmployeesScreen(
      //                         employees: employees,
      //                       );
      //                     }),
      //                   );
      //                 } else {
      //                   ScaffoldMessenger.of(context).showSnackBar(
      //                     const SnackBar(
      //                         content: Text(
      //                             'Failed to load employees. Please try again later.')),
      //                   );
      //                 }
      //                 break;

      //               case 'Add New Employee':
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) {
      //                     return AddEmployeeScreen();
      //                   }),
      //                 );
      //                 break;

      //               case 'Add New Admin':
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) {
      //                     return AddAdminScreen();
      //                   }),
      //                 );
      //                 break;

      //               case 'Show All Points':
      //                 AppPointsService aas = AppPointsService();
      //                 List<PointModel?>? points = await aas.GetAllPoint();

      //                 if (points != null) {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(builder: (context) {
      //                       return ShowAllPointsScreen(
      //                         points: points,
      //                       );
      //                     }),
      //                   );
      //                 } else {
      //                   ScaffoldMessenger.of(context).showSnackBar(
      //                     const SnackBar(
      //                         content: Text(
      //                             'Failed to load employees. Please try again later.')),
      //                   );
      //                 }
      //                 break;

      //               case 'statistics':
      //                 AppPointsService aas = AppPointsService();
      //                 List<PointModel?>? points = await aas.GetAllPoint();
      //                 AppBranchesService ass2 = AppBranchesService();
      //                 int? branchesCount = await ass2.getBranchesCount() ?? 0;
      //                 AppEmployeesService aas3 = AppEmployeesService();
      //                 Map<String, int>? employeeCount =
      //                     await aas3.getEmployeesCount();
      //                 print(branchesCount);
      //                 print(employeeCount);
                      


      //                 if (points != null && employeeCount != null) {
      //                   List<int> pointsCount = points
      //                       .map((points) => points!.points_count)
      //                       .toList();
      //                   print(pointsCount);
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(builder: (context) {
      //                       return statistics_screen(
      //                         points: pointsCount,
      //                         branchesCount: branchesCount,
      //                         employeeCount: employeeCount,
      //                       );
      //                     }),
      //                   );
      //                 } else {
      //                   ScaffoldMessenger.of(context).showSnackBar(
      //                     const SnackBar(
      //                         content: Text(
      //                             'Failed to load employees. Please try again later.')),
      //                   );
      //                 }
      //                 break;
      //             }
      //           }
      //         },
      //       ),
      //     ),
      //     Container(
      //       margin: const EdgeInsets.symmetric(horizontal: 20),
      //       child: MaterialButton(
      //         color: Colors.red,
      //         textColor: Colors.white,
      //         onPressed: () {
      //           // Navigating to About Us page
      //           Navigator.of(context).pushNamed('mainscreen');
      //         },
      //         child: const Text("Go to About Us by pushReplacementNamed"),
      //       ),
      //     ),
      //   ],
      // ),
    )
    );
  }
}
