import 'package:clothes_store/screens/admin/HomeScreen.dart';
import 'package:clothes_store/screens/admin/add_accessory_screen.dart';
import 'package:clothes_store/screens/customer_service/customer_service_main_screen.dart';
import 'package:clothes_store/screens/shared_screen/MainScreen.dart';

import 'package:clothes_store/screens/admin/add_company_screen.dart';
import 'package:clothes_store/screens/admin/add_employee_screen.dart';
import 'package:clothes_store/screens/shared_screen/login_screen.dart';
import 'package:clothes_store/screens/manager/manager_main_screen.dart';
import 'package:clothes_store/screens/manager/manager_statistics_screen.dart';
import 'package:clothes_store/screens/manager/show_all_managers_employees.dart';
import 'package:clothes_store/screens/admin/show_all_accessories_screen.dart';
import 'package:clothes_store/screens/admin/show_all_branches_screen.dart';
import 'package:clothes_store/screens/admin/show_all_companies_screen.dart';
import 'package:clothes_store/screens/admin/show_all_points_screen.dart';
import 'package:clothes_store/screens/admin/statistics_screen.dart';
import 'package:clothes_store/screens/supervisor/supervisor_main_screen.dart';
import 'package:clothes_store/screens/supervisor/supervisor_statistic_screen.dart';
import 'package:clothes_store/screens/admin/update_accessory_screen.dart';
import 'package:clothes_store/screens/admin/update_branch_screen.dart';
import 'package:clothes_store/screens/admin/update_company_screen.dart';
import 'package:clothes_store/screens/admin/update_employee_screen.dart';
import 'package:clothes_store/screens/shared_screen/user_profile_screen.dart';
import 'package:clothes_store/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/screens/admin/add_company_screen.dart';
import 'package:clothes_store/screens/admin/add_branch_screen.dart';

import 'package:clothes_store/screens/admin/add_employee_screen.dart';
import 'package:clothes_store/screens/admin/show_all_employees.dart';
import 'package:clothes_store/services/company_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/accessory_model.dart';
import 'package:clothes_store/screens/shared_screen/MainScreen.dart';

import '../services/accessory_services.dart';
import 'services/auth_remastered.dart';

void main() {
  runApp(
    // for authunticated
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
      ],
      child: const ClothesStore(),
    ),
  );
}

class ClothesStore extends StatelessWidget {
  const ClothesStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SupervisorMainScreen(),
        routes: {
          // ************************************* admin route *****************************
          "home": (context) => HomeScreen(),
          "admin_main_Screen": (context) =>
              HomeScreen(), // Add your screen here
          // "supervisorScreen": (context) => SupervisorScreen(), // Add your screen here
          // "customerServiceScreen": (context) => CustomerServiceScreen(), // Add your screen here
          "userProfile": (context) => UserProfile(), // Add your new route here
          "mainscreen": (context) => MainScreen(),
          "addAccessory": (context) => const AddAccessoryScreen(
                branch_id: '',
              ),
          "addCompany": (context) => AddCompanyScreen(),
          "addEmployee": (context) => AddEmployeeScreen(),
          "addBranch": (context) => const AddBranchScreen(
                company_id: '',
              ),
          "showAccessories": (context) => const ShowAllAccessoriesScreen(
                accessories: [],
              ),
          "showBranches": (context) => const ShowAllBranchesScreen(
                branches: [],
              ),
          "showCompanies": (context) => const ShowAllCompaniesScreen(
                companies: [],
              ),
          "showEmployees": (context) => const ShowAllEmployeesScreen(
                employees: [],
              ),
          "showPoints": (context) => const ShowAllPointsScreen(
                points: [],
              ),
          // "updateEmployee":(context) => UpdateEmployeeScreen(employee: null,),
          "updateCompany": (context) => UpdateCompanyScreen(
                company: null,
              ),
          "updateBranch": (context) => UpdateBranchScreen(
                branch: null,
              ),
          "updateAccessories": (context) => UpdateAccessoryScreen(
                accessory: null,
              ),
          //  "statistics_screen":(context) => const statistics_screen(branchesCount: 0, points: [],employeeCount :[]),
          "statistics_screen": (context) => const statistics_screen(
                branchesCount: 0,
                points: [],
                // employeesCount: [],
                employeeCount: {
                  'employee_count': 0,
                  'customer_service_count': 0,
                  'manager_count': 0,
                  'supervisor_count': 0,
                },
              ),

          // ******************************************   managers route *********************************
          "manager_mainScreen": (context) =>
              ManagerMainScreen(), // Add your screen here  managers_statistics
          "managers_statistics": (context) => const ManagerStatisticScreen(
                employeeCount: {},
              ), // Add your screen here  managers_statistics

          // ******************************************   supervisor route *********************************
          "supervisor_mainScreen": (context) =>
              SupervisorMainScreen(), // Add your screen here  supervisor
          "supervisors_statistics": (context) => const SupervisiorStatisticScreen(
                employeeCount: {},
              ), // Add your screen here  supervisor_statistics

          // ******************************************   supervisor route *********************************
          "customerService_mainScreen": (context) =>
              CutmoerServiceMainScreen(), // Add your screen here  supervisor
        });
  }
}

// import 'package:clothes_store/screens/admin/add_branch_screen.dart';
// import 'package:clothes_store/screens/admin/show_all_employees.dart';
// import 'package:clothes_store/screens/admin/statistics_screen.dart';
// import 'package:clothes_store/services/auth_remastered.dart';
// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:provider/provider.dart';
// import 'dart:convert';

// // Import your existing screens
// import 'package:clothes_store/screens/admin/HomeScreen.dart';
// import 'package:clothes_store/screens/customer_service/customer_service_main_screen.dart';
// import 'package:clothes_store/screens/shared_screen/MainScreen.dart';
// import 'package:clothes_store/screens/admin/add_accessory_screen.dart';
// import 'package:clothes_store/screens/admin/add_company_screen.dart';
// import 'package:clothes_store/screens/admin/add_employee_screen.dart';
// import 'package:clothes_store/screens/admin/show_all_accessories_screen.dart';
// import 'package:clothes_store/screens/admin/show_all_branches_screen.dart';
// import 'package:clothes_store/screens/admin/show_all_companies_screen.dart';
// import 'package:clothes_store/screens/admin/show_all_points_screen.dart';
// import 'package:clothes_store/screens/admin/update_accessory_screen.dart';
// import 'package:clothes_store/screens/admin/update_branch_screen.dart';
// import 'package:clothes_store/screens/admin/update_company_screen.dart';
// import 'package:clothes_store/screens/manager/manager_main_screen.dart';
// import 'package:clothes_store/screens/manager/manager_statistics_screen.dart';
// import 'package:clothes_store/screens/supervisor/supervisor_main_screen.dart';
// import 'package:clothes_store/screens/supervisor/supervisor_statistic_screen.dart';
// import 'package:clothes_store/screens/shared_screen/user_profile_screen.dart';
// import 'package:clothes_store/services/auth.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => Auth()),
//       ],
//       child: const ClothesStore(),
//     ),
//   );
// }

// class ClothesStore extends StatefulWidget {
//   const ClothesStore({super.key});

//   @override
//   _ClothesStoreState createState() => _ClothesStoreState();
// }

// class _ClothesStoreState extends State<ClothesStore> {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   final WebSocketChannel channel = WebSocketChannel.connect(
//     Uri.parse('ws://127.0.0.1:6001/app/your-app-key?protocol=7&client=js&version=4.4.0'),
//   );
//   List notifications = [];

//   @override
//   void initState() {
//     super.initState();
//     var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
//     var initializationSettingsIOS = IOSInitializationSettings();
//     var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     channel.stream.listen((message) {
//       final decodedMessage = json.decode(message);
//       if (decodedMessage['event'] == 'App\\Events\\NotificationCreated') {
//         setState(() {
//           notifications.add(decodedMessage['data']);
//         });
//         _showNotification(decodedMessage['data']);
//       }
//     });
//   }

//   Future<void> _showNotification(Map<String, dynamic> data) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       'your_channel_description',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: false,
//     );
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       data['title'],
//       data['body'],
//       platformChannelSpecifics,
//       payload: data['url'],
//     );
//   }

//   @override
//   void dispose() {
//     channel.sink.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CutmoerServiceMainScreen(),
//       routes: {
//         "home": (context) => HomeScreen(),
//         "admin_main_Screen": (context) => HomeScreen(),
//         "userProfile": (context) => UserProfile(),
//         "mainscreen": (context) => MainScreen(),
//         "addAccessory": (context) => AddAccessoryScreen(branch_id: '',),
//         "addCompany": (context) => AddCompanyScreen(),
//         "addEmployee": (context) => AddEmployeeScreen(),
//         "addBranch": (context) => AddBranchScreen(company_id: '',),
//         "showAccessories": (context) => ShowAllAccessoriesScreen(accessories: [],),
//         "showBranches": (context) => ShowAllBranchesScreen(branches: [],),
//         "showCompanies": (context) => ShowAllCompaniesScreen(companies: [],),
//         "showEmployees": (context) => ShowAllEmployeesScreen(employees: [],),
//         "showPoints": (context) => ShowAllPointsScreen(points: [],),
//         "updateCompany": (context) => UpdateCompanyScreen(company: null,),
//         "updateBranch": (context) => UpdateBranchScreen(branch: null,),
//         "updateAccessories": (context) => UpdateAccessoryScreen(accessory: null,),
//         "statistics_screen": (context) => const statistics_screen(
//           branchesCount: 0,
//           points: [],
//           employeeCount: {
//             'employee_count': 0,
//             'customer_service_count': 0,
//             'manager_count': 0,
//             'supervisor_count': 0,
//           },
//         ),
//         "manager_mainScreen": (context) => ManagerMainScreen(),
//         "managers_statistics": (context) => ManagerStatisticScreen(employeeCount: {}),
//         "supervisor_mainScreen": (context) => SupervisorMainScreen(),
//         "supervisors_statistics": (context) => SupervisiorStatisticScreen(employeeCount: {}),
//         "customerService_mainScreen": (context) => CutmoerServiceMainScreen(),
//       },
//     );
//   }
// }

// import 'package:clothes_store/screens/admin/add_branch_screen.dart';
// import 'package:clothes_store/screens/admin/show_all_employees.dart';
// import 'package:clothes_store/screens/admin/statistics_screen.dart';
// import 'package:clothes_store/screens/customer_service/notification_screen.dart';
// import 'package:clothes_store/services/auth_remastered.dart';
// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:provider/provider.dart';
// import 'dart:convert';

// import 'package:clothes_store/screens/admin/HomeScreen.dart';
// import 'package:clothes_store/screens/customer_service/customer_service_main_screen.dart';
// import 'package:clothes_store/screens/shared_screen/MainScreen.dart';
// import 'package:clothes_store/screens/admin/add_accessory_screen.dart';
// import 'package:clothes_store/screens/admin/add_company_screen.dart';
// import 'package:clothes_store/screens/admin/add_employee_screen.dart';
// import 'package:clothes_store/screens/admin/show_all_accessories_screen.dart';
// import 'package:clothes_store/screens/admin/show_all_branches_screen.dart';
// import 'package:clothes_store/screens/admin/show_all_companies_screen.dart';
// import 'package:clothes_store/screens/admin/show_all_points_screen.dart';
// import 'package:clothes_store/screens/admin/update_accessory_screen.dart';
// import 'package:clothes_store/screens/admin/update_branch_screen.dart';
// import 'package:clothes_store/screens/admin/update_company_screen.dart';
// import 'package:clothes_store/screens/manager/manager_main_screen.dart';
// import 'package:clothes_store/screens/manager/manager_statistics_screen.dart';
// import 'package:clothes_store/screens/supervisor/supervisor_main_screen.dart';
// import 'package:clothes_store/screens/supervisor/supervisor_statistic_screen.dart';
// import 'package:clothes_store/screens/shared_screen/user_profile_screen.dart';
// import 'package:clothes_store/services/auth.dart';
// import 'package:clothes_store/screens/customer_service/notification_screen.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => Auth()),
//       ],
//       child: const ClothesStore(),
//     ),
//   );
// }

// class ClothesStore extends StatefulWidget {
//   const ClothesStore({super.key});

//   @override
//   _ClothesStoreState createState() => _ClothesStoreState();
// }

// class _ClothesStoreState extends State<ClothesStore> {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   final WebSocketChannel channel = WebSocketChannel.connect(
//     Uri.parse('ws://127.0.0.1:6001/app/f324028bc7f0f9be6a58?protocol=7&client=js&version=4.4.0'),
//   );
//   List<Map<String, dynamic>> notifications = [];

//   @override
//   void initState() {
//     super.initState();
//     var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
//     var initializationSettingsIOS = IOSInitializationSettings();
//     var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     channel.stream.listen((message) {
//       final decodedMessage = json.decode(message);
//       if (decodedMessage['event'] == 'App\\Events\\NotificationCreated') {
//         setState(() {
//           notifications.add(decodedMessage['data']);
//         });
//         _showNotification(decodedMessage['data']);
//       }
//     });
//   }

//   Future<void> _showNotification(Map<String, dynamic> data) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       'your_channel_description',
//       importance: Importance.max,
//       priority: Priority.high,
//       showWhen: false,
//     );
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       data['title'],
//       data['body'],
//       platformChannelSpecifics,
//       payload: data['url'],
//     );
//   }

//   @override
//   void dispose() {
//     channel.sink.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CutmoerServiceMainScreen(),
//       routes: {
//         "home": (context) => HomeScreen(),
//         "admin_main_Screen": (context) => HomeScreen(),
//         "userProfile": (context) => UserProfile(),
//         "mainscreen": (context) => MainScreen(),
//         "addAccessory": (context) => AddAccessoryScreen(branch_id: '',),
//         "addCompany": (context) => AddCompanyScreen(),
//         "addEmployee": (context) => AddEmployeeScreen(),
//         "addBranch": (context) => AddBranchScreen(company_id: '',),
//         "showAccessories": (context) => ShowAllAccessoriesScreen(accessories: [],),
//         "showBranches": (context) => ShowAllBranchesScreen(branches: [],),
//         "showCompanies": (context) => ShowAllCompaniesScreen(companies: [],),
//         "showEmployees": (context) => ShowAllEmployeesScreen(employees: [],),
//         "showPoints": (context) => ShowAllPointsScreen(points: [],),
//         "updateCompany": (context) => UpdateCompanyScreen(company: null,),
//         "updateBranch": (context) => UpdateBranchScreen(branch: null,),
//         "updateAccessories": (context) => UpdateAccessoryScreen(accessory: null,),
//         "statistics_screen": (context) => const statistics_screen(
//           branchesCount: 0,
//           points: [],
//           employeeCount: {
//             'employee_count': 0,
//             'customer_service_count': 0,
//             'manager_count': 0,
//             'supervisor_count': 0,
//           },
//         ),
//         "manager_mainScreen": (context) => ManagerMainScreen(),
//         "managers_statistics": (context) => ManagerStatisticScreen(employeeCount: {}),
//         "supervisor_mainScreen": (context) => SupervisorMainScreen(),
//         "supervisors_statistics": (context) => SupervisiorStatisticScreen(employeeCount: {}),
//         "customerService_mainScreen": (context) => CutmoerServiceMainScreen(),
//         "notifications": (context) => NotificationScreen(notifications: notifications),
//       },
//     );
//   }
// }
