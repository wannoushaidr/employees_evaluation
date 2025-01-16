import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/models/point_model.dart';
import 'package:clothes_store/screens/add_company_screen.dart';
import 'package:clothes_store/screens/add_employee_screen.dart';
import 'package:clothes_store/screens/login_screen.dart';
import 'package:clothes_store/screens/show_all_employees.dart';
import 'package:clothes_store/screens/show_all_points_screen.dart';
import 'package:clothes_store/screens/statistics_screen.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:clothes_store/services/company_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:clothes_store/services/point_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clothes_store/services/auth.dart';

import '../models/accessory_model.dart';
import 'package:clothes_store/screens/MainScreen.dart';

import '../services/accessory_services.dart';
import 'add_accessory_screen.dart';
import 'show_all_accessories_screen.dart';
import 'show_all_companies_screen.dart';
import 'update_company_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
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
                            leading:Icon(Icons.home),
                              title:Container(  
                            margin: EdgeInsets.symmetric(horizontal: 20),  
                            child: MaterialButton(  
                              // color: Colors.red,  
                              textColor: Colors.black,  
                              onPressed: () {  
                                // Navigating to About Us page  
                                Navigator.of(context).pushNamed('home');
                              },  
                              // leading:Icon(Icons.home),
                              child: const Text("add new",textAlign: TextAlign.left,),  

                            ),  
                              )
                            ),

                            ListTile(
                            leading:Icon(Icons.home),
                              title:Container(  
                            margin: EdgeInsets.symmetric(horizontal: 20),  
                            child: MaterialButton(  
                              // color: Colors.red,  
                              textColor: Colors.black,  
                              onPressed: () {  
                                // Navigating to About Us page  
                                Navigator.of(context).pushNamed('userProfile');
                              },  
                              // leading:Icon(Icons.home),
                              child: const Text("userProfile",textAlign: TextAlign.left,),  

                            ),  
                              )
                            ),


                            ListTile(
                              leading:Icon(Icons.home),
                              title:Container(  
                            margin: EdgeInsets.symmetric(horizontal: 20),  
                            child: MaterialButton(  
                              // color: Colors.red,  
                              textColor: Colors.black,  
                              onPressed: () {  
                                // Navigating to About Us page  
                                Navigator.of(context).pushNamed('statistics_screen');
                              },  
                              // leading:Icon(Icons.home),
                              child: const Text("statistics",textAlign: TextAlign.left,),  

                            ),  
                              )
                            ),
                            ListTile(
                            leading:Icon(Icons.home),
                              title:Container(  
                            margin: EdgeInsets.symmetric(horizontal: 20),  
                            child: MaterialButton(  
                              // color: Colors.red,  
                              textColor: Colors.black,  
                              onPressed: () {  
                                // Navigating to About Us page  
                                Navigator.of(context).pushNamed('showEmployees');
                              },  
                              // leading:Icon(Icons.home),
                              child: const Text("employees",textAlign: TextAlign.left,),  

                            ),  
                              )
                            ),
                            ListTile(
                              leading:Icon(Icons.home),
                              title:Container(  
                            margin: EdgeInsets.symmetric(horizontal: 20),  
                            child: MaterialButton(  
                              // color: Colors.red,  
                              textColor: Colors.black,  
                              onPressed: () {  
                                // Navigating to About Us page  
                                Navigator.of(context).pushNamed('showBranches');
                              },  
                              // leading:Icon(Icons.home),
                              child: const Text("branches",textAlign: TextAlign.left,),  

                            ),  
                              )
                            ),
                            ListTile(
                              leading:Icon(Icons.home),
                              title:Container(  
                            margin: EdgeInsets.symmetric(horizontal: 20),  
                            child: MaterialButton(  
                              // color: Colors.red,  
                              textColor: Colors.black,  
                              onPressed: () {  
                                // Navigating to About Us page  
                                Navigator.of(context).pushNamed('home');
                              },  
                              // leading:Icon(Icons.home),
                              child: const Text("go to home",textAlign: TextAlign.left,),  

                            ),  
                              )
                            ),
                          
                          ListTile(
                              leading:const Icon(Icons.logout),
                              title:const Text("logout"),
                              onTap: (){
                                Provider.of<Auth>(context,listen: false)
                                  ..logout();
                              },
                            ),
                            
                          ],
                          );
                            }
                      }) 
                      ),

      // );
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton<String>(
              hint: Text('Select'),
              items: <String>[
                'Show All Companies',
                'Add New Company',
                'Show All Accessories',
                // 'Add New Accessory',
                'Show All Employees',
                'Add New Employee',
                'Show All Points',
                'statistics'
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) async {
                if (newValue != null) {
                  switch (newValue) {
                    case 'Show All Companies':
                      AppCompaniesService acp = AppCompaniesService();
                      List<CompanyModel?>? companies =
                          await acp.GetAllCompanies();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ShowAllCompaniesScreen(
                            companies: companies,
                          );
                        }),
                      );
                      break;
                    case 'Add New Company':
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return AddCompanyScreen();
                        }),
                      );
                      break;
                    case 'Show All Accessories':
                      AppAccessoriesService aas = new AppAccessoriesService();
                      List<AccessoryModel?>? accessories =
                          await aas.GetAllAccessories();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ShowAllAccessoriesScreen(
                            accessories: accessories,
                          );
                        }),
                      );
                      break;
                    // case 'Add New Accessory':
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) {
                    //       return AddAccessoryScreen(branch_id: ,);
                    //     }),
                    //   );
                    //   break;


                    // case 'Show All Employees':
                    //   AppEmployeesService aas = new AppEmployeesService();
                    //   List<EmployeeModel?>? employees =
                    //       await aas.GetAllEmployees();
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) {
                    //       return ShowAllEmployeesScreen(
                    //         employees: employees,
                    //       );
                    //     }),
                    //   );
                    //   break;


                        case 'Show All Employees':
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
                            SnackBar(content: Text('Failed to load employees. Please try again later.')),
                          );
                        }
                        break;



                      
                    case 'Add New Employee':
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return AddEmployeeScreen();
                        }),
                      );
                      break;

                    case 'Show All Points':
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
                            SnackBar(content: Text('Failed to load employees. Please try again later.')),
                          );
                        }
                        break;

                        case 'statistics':
                        AppPointsService aas = AppPointsService();
                        List<PointModel?>? points = await aas.GetAllPoint();
                        AppBranchesService ass2= AppBranchesService();
                        int? branchesCount = await ass2.getBranchesCount() ?? 0;
                        AppEmployeesService aas3 = AppEmployeesService();
                          Map<String, int>? employeeCount = await aas3.getEmployeesCount();
                          print(branchesCount);
                          print(employeeCount);
                        
                        if (points != null && employeeCount != null) {
                          List<int> pointsCount = points.map((points) => points!.points_count).toList();
                          print(pointsCount);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return statistics_screen(
                                points: pointsCount,
                                branchesCount: branchesCount,
                                employeeCount :  employeeCount ,
                              );
                            }),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to load employees. Please try again later.')),
                          );
                        }
                        break;
                  }
                }
              },
            ),
             Container(  
            margin: EdgeInsets.symmetric(horizontal: 20),  
            child: MaterialButton(  
              color: Colors.red,  
              textColor: Colors.white,  
              onPressed: () {  
                // Navigating to About Us page  
                Navigator.of(context).pushNamed('mainscreen');
              },  
              child: const Text("Go to About Us by pushReplacementNamed"),  
            ),  
          ),  
          ],
        ),
      ),
    );
  }
}
