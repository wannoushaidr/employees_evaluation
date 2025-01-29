import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/models/point_model.dart';
import 'package:clothes_store/screens/shared_screen/login_screen.dart';
import 'package:clothes_store/screens/manager/activate_employee_screen.dart';
import 'package:clothes_store/screens/manager/manager_statistics_screen.dart';
import 'package:clothes_store/screens/manager/show_all_managers_employees.dart';
import 'package:clothes_store/screens/admin/show_all_companies_screen.dart';
import 'package:clothes_store/screens/supervisor/supervisor_statistic_screen.dart';
import 'package:clothes_store/screens/shared_screen/user_profile_screen.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:clothes_store/services/company_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:clothes_store/services/point_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clothes_store/services/auth.dart';

import '../../services/auth_remastered.dart'; // Import your Auth class

class SupervisorMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return Scaffold(
      appBar: AppBar(title: Text('supervisior')),

     
     
     
      drawer: Drawer(   
                              child:Consumer<Auth>(builder:(context,auth,child){
                                // if (!  auth!.authenticated){
                                if (!  auth.authenticated){
                                  return ListView( 
                                    children: [
                                      ListTile(
                                  leading:const Icon(Icons.login),
                                  title:const Text("loginn"),
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
                                  },
                                  )],
                                );
                                // );

                                }
                                else{
                              return ListView(children: [

                            IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: DrawerHeader(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 30,
                              ),
                              const SizedBox(height: 10),
                              Text(auth.user.name, style: const TextStyle(color: Colors.black)),
                              const SizedBox(height: 10),
                              Text(auth.user.email, style: const TextStyle(color: Colors.black)),
                              // const SizedBox(height: 10),
                              // Text(auth.user.role, style: const TextStyle(color: Colors.black)),
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


                            ListTile(
                              title:ElevatedButton(
                                          onPressed: () async {
                                            // Your new button functionality goes here
                                            print('profile');
                                           
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return UserProfile();
                                                  },
                                                ),
                                              );
                                            // Example: Fetch another set of data or navigate to a different screen
                                          },
                                          child: Text('profile'),
                                        ),
                            ),

                            ListTile(
                              title:ElevatedButton(
                                          onPressed: () async {
                                                                        AppEmployeesService acp = AppEmployeesService();
                                              List<EmployeeModel?>? employees = await acp.GetMyAtivateEmployee(auth.user.id);
                                              print(employees);

                                              if (employees != null) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return showActivateEmployees(employees: employees);
                                                    },
                                                  ),
                                                );
                                              }
                                            // Example: Fetch another set of data or navigate to a different screen
                                          },
                                          child: Text('employees activae'),
                                        ),
                            ),

                             ListTile(
                              title:ElevatedButton(
                                          onPressed: () async {
                                                                        AppEmployeesService acp = AppEmployeesService();
                                              List<EmployeeModel?>? employees = await acp.GetMyEmployeesEnformation(auth.user.id);
                                              print(employees);

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
                                            // Example: Fetch another set of data or navigate to a different screen
                                          },
                                          child: Text('employees information'),
                                        ),
                            ),

                            ListTile(
                              title:ElevatedButton(
                                          onPressed: () async {
                                           // Your new button functionality goes here
                                            print('Second button pressed');
                                            AppPointsService aas = AppPointsService();
                                                    AppEmployeesService aas3 = AppEmployeesService();
                                                      Map<String, int>? employeeCount = await aas3.getCustomerServiceEmployeesCount(auth.user.id);

                                            if (employeeCount != null) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return SupervisiorStatisticScreen(employeeCount: employeeCount,);
                                                  },
                                                ),
                                              );
                                            }
                                            // Example: Fetch another set of data or navigate to a different screen
                                          },
                                          child: Text('statistic'),
                                        ),
                            ),

                          
                            ListTile(
                            title:ElevatedButton(
                                          
                                            onPressed: () async {
                                            
                                            // if (employees != null) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return SupervisorMainScreen();
                                                    }
                                                  ),
                                                );
                                              
                                            // }
                                            },
                                            // Example: Fetch another set of data or navigate to a different screen
                                          // },
                                          child: Text('main screen'),
                                        ),
                            ),

                          
                          ListTile(
                              leading:const Icon(Icons.logout),
                              title:const Text("logout"),
                              onTap: (){
                                Provider.of<Auth>(context,listen: false)
                                  .logout();
                                   Navigator.pushReplacementNamed(context, 'mainscreen');
                              },
                            ),
                            
                          ],
                          );
                            }
                      }) 
                      ),
     
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10),
            Text('Name: ${auth.user.name}'),
            SizedBox(height: 5),
            Text('Email: ${auth.user.email}'),
            SizedBox(height: 5),
            Text('Role: ${auth.user.role}'),
            ElevatedButton(
              onPressed: () async {
                AppEmployeesService acp = AppEmployeesService();
                List<EmployeeModel?>? employees = await acp.GetMyEmployeesEnformation(auth.user.id);
                print(employees);

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
              child: Text('Show Employees by supervisior'),
            ),

            ElevatedButton(
              onPressed: () async {
                // Your new button functionality goes here
                AppPointsService aas = AppPointsService();
                        AppEmployeesService aas3 = AppEmployeesService();
                          Map<String, int>? employeeCount = await aas3.getCustomerServiceEmployeesCount(auth.user.id);

                if (employeeCount != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SupervisiorStatisticScreen(employeeCount: employeeCount,);
                      },
                    ),
                  );
                }
                // Example: Fetch another set of data or navigate to a different screen
              },
              child: Text('statistic'),
            ),
          ],
        ),
      ),
    );
  }
}
