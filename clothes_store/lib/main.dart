import 'package:clothes_store/screens/HomeScreen.dart';
import 'package:clothes_store/screens/add_accessory_screen.dart';
import 'package:clothes_store/screens/MainScreen.dart';

import 'package:clothes_store/screens/add_company_screen.dart';
import 'package:clothes_store/screens/add_employee_screen.dart';
import 'package:clothes_store/screens/show_all_accessories_screen.dart';
import 'package:clothes_store/screens/show_all_branches_screen.dart';
import 'package:clothes_store/screens/show_all_companies_screen.dart';
import 'package:clothes_store/screens/statistic.dart';
import 'package:clothes_store/screens/update_accessory_screen.dart';
import 'package:clothes_store/screens/update_branch_screen.dart';
import 'package:clothes_store/screens/update_company_screen.dart';
import 'package:clothes_store/screens/update_employee_screen.dart';
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
      home: HomeScreen(),
      routes: {
        "home":(context) => HomeScreen(),
        "mainscreen":(context) => MainScreen(),
        "addAccessory":(context) => AddAccessoryScreen(branch_id: '',),
        "addCompany":(context) => AddCompanyScreen(),
        "addEmployee":(context) => AddEmployeeScreen(),
        "addBranch":(context) => AddBranchScreen(company_id: '',),
        "showAccessories":(context) => ShowAllAccessoriesScreen(accessories: [],),
        "showBranches":(context) => ShowAllBranchesScreen(branches: [],),
        "showCompanies":(context) => ShowAllCompaniesScreen(companies: [],),
        "showEmployees":(context) => ShowAllEmployeesScreen(employees: [],),
        // "updateEmployee":(context) => UpdateEmployeeScreen(employee: null,),
        "updateCompany":(context) => UpdateCompanyScreen(company: null,),
        "updateBranch":(context) => UpdateBranchScreen(branch: null,),
        "updateAccessories":(context) => UpdateAccessoryScreen(accessory: null,),
         "statistic":(context) => statistic(accessory: null, accessories: [],),


      },
    );
  }
}
