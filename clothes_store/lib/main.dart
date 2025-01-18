import 'package:clothes_store/screens/HomeScreen.dart';
import 'package:clothes_store/screens/add_accessory_screen.dart';
import 'package:clothes_store/screens/MainScreen.dart';

import 'package:clothes_store/screens/add_company_screen.dart';
import 'package:clothes_store/screens/add_employee_screen.dart';
import 'package:clothes_store/screens/manager/manager_main_screen.dart';
import 'package:clothes_store/screens/manager/manager_statistics_screen.dart';
import 'package:clothes_store/screens/manager/show_all_managers_employees.dart';
import 'package:clothes_store/screens/show_all_accessories_screen.dart';
import 'package:clothes_store/screens/show_all_branches_screen.dart';
import 'package:clothes_store/screens/show_all_companies_screen.dart';
import 'package:clothes_store/screens/show_all_points_screen.dart';
import 'package:clothes_store/screens/statistics_screen.dart';
import 'package:clothes_store/screens/supervisor/supervisor_main_screen.dart';
import 'package:clothes_store/screens/supervisor/supervisor_statistic_screen.dart';
import 'package:clothes_store/screens/update_accessory_screen.dart';
import 'package:clothes_store/screens/update_branch_screen.dart';
import 'package:clothes_store/screens/update_company_screen.dart';
import 'package:clothes_store/screens/update_employee_screen.dart';
import 'package:clothes_store/screens/user_profile_screen.dart';
import 'package:clothes_store/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/screens/add_company_screen.dart';
import 'package:clothes_store/screens/add_branch_screen.dart';

import 'package:clothes_store/screens/add_employee_screen.dart';
import 'package:clothes_store/screens/show_all_employees.dart';
import 'package:clothes_store/services/company_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../models/accessory_model.dart';
import 'package:clothes_store/screens/MainScreen.dart';

import '../services/accessory_services.dart';

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
        "home":(context) => HomeScreen(),
        "admin_main_Screen": (context) => HomeScreen(), // Add your screen here 
        // "supervisorScreen": (context) => SupervisorScreen(), // Add your screen here 
        // "customerServiceScreen": (context) => CustomerServiceScreen(), // Add your screen here
        "userProfile": (context) => UserProfile(), // Add your new route here
        "mainscreen":(context) => MainScreen(),
        "addAccessory":(context) => AddAccessoryScreen(branch_id: '',),
        "addCompany":(context) => AddCompanyScreen(),
        "addEmployee":(context) => AddEmployeeScreen(),
        "addBranch":(context) => AddBranchScreen(company_id: '',),
        "showAccessories":(context) => ShowAllAccessoriesScreen(accessories: [],),
        "showBranches":(context) => ShowAllBranchesScreen(branches: [],),
        "showCompanies":(context) => ShowAllCompaniesScreen(companies: [],),
        "showEmployees":(context) => ShowAllEmployeesScreen(employees: [],),
        "showPoints":(context) => ShowAllPointsScreen(points: [],),
        // "updateEmployee":(context) => UpdateEmployeeScreen(employee: null,),
        "updateCompany":(context) => UpdateCompanyScreen(company: null,),
        "updateBranch":(context) => UpdateBranchScreen(branch: null,),
        "updateAccessories":(context) => UpdateAccessoryScreen(accessory: null,),
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
          "manager_mainScreen": (context) => ManagerMainScreen(), // Add your screen here  managers_statistics
          "managers_statistics": (context) => ManagerStatisticScreen( employeeCount: {},), // Add your screen here  managers_statistics

          // ******************************************   supervisor route *********************************
          "supervisor_mainScreen": (context) => SupervisorMainScreen(), // Add your screen here  supervisor
          "supervisors_statistics": (context) => SupervisiorStatisticScreen( employeeCount: {},), // Add your screen here  supervisor_statistics



}



    );
  }
}
