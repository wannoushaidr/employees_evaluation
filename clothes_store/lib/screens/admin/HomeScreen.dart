import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/models/point_model.dart';
import 'package:clothes_store/models/user.dart';
import 'package:clothes_store/screens/admin/add_admin_screen.dart';
import 'package:clothes_store/screens/admin/add_company_screen.dart';
import 'package:clothes_store/screens/admin/add_employee_screen.dart';
import 'package:clothes_store/screens/admin/add_new_screen.dart';
import 'package:clothes_store/screens/admin/show_user_screen.dart';
import 'package:clothes_store/screens/shared_screen/login_screen.dart';
import 'package:clothes_store/screens/admin/show_all_branches_screen.dart';
import 'package:clothes_store/screens/admin/show_all_employees.dart';
import 'package:clothes_store/screens/admin/show_all_points_screen.dart';
import 'package:clothes_store/screens/admin/statistics_screen.dart';
import 'package:clothes_store/screens/shared_screen/user_profile_screen.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:clothes_store/services/company_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:clothes_store/services/point_services.dart';
import 'package:clothes_store/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clothes_store/services/auth.dart';

import '../../models/accessory_model.dart';
import 'package:clothes_store/screens/shared_screen/MainScreen.dart';

import '../../services/accessory_services.dart';
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
                            if (  !auth.authenticated){
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
                                           
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) {
                                                    return AddNewScreen();
                                                  },
                                                ),
                                              );
                                            // Example: Fetch another set of data or navigate to a different screen
                                          },
                                          child: Text('add new'),
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
                                            // Your new button functionality goes here
                                            print('statistic');
                                           
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
                                            // Example: Fetch another set of data or navigate to a different screen
                                          },
                                          child: Text('statistic'),
                                        ),
                            ),

                            


                            ListTile(
                              title:ElevatedButton(
                                          onPressed: () async {
                                            // Your new button functionality goes here
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
                       
                                          },
                                          child: Text('employees'),
                                        ),
                                     ),


                            
                            

                            ListTile(
                              title:ElevatedButton(
                                          onPressed: () async {
                                            // Your new button functionality goes here
                                            AppBranchesService aas = AppBranchesService();
                                            print("ssssssssssssss");
                                              List<BranchModel?>? branches = await aas.GetAllBranches();
                                              print("ssssss32222222222");
                                              print(branches);
                                              
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
                                                  SnackBar(content: Text('Failed to load employees. Please try again later.')),
                                                );
                                              }
                       
                                          },
                                          child: Text('bracnhes'),
                                        ),
                             ),


                             ListTile(
                              title:ElevatedButton(
                                          onPressed: () async {
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
                       
                                          },
                                          child: Text('points'),
                                        ),
                             ),

                             ListTile(
                              title:ElevatedButton(
                                          onPressed: () async {
                                            // Navigating to About Us page  
                                             Navigator.of(context).pushNamed('home');
                                  
                                          },
                                          child: Text('home'),
                                        ),
                             ),

                             ListTile(
                              title:ElevatedButton(
                                          onPressed: () async {
                                            // Your new button functionality goes here
                                            AppUsersService aas = AppUsersService();
                                            print("users1");
                                              List<UserModel?>? users = await aas.GetAllUsers();
                                              print("user2");
                                              print(users);
                                              
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
                                                  SnackBar(content: Text('Failed to load employees. Please try again later.')),
                                                );
                                              }
                       
                                          },
                                          child: Text('users'),
                                        ),
                             ),

                          
                          ListTile(
                              leading:const Icon(Icons.logout),
                              title:const Text("logout"),
                              onTap: (){
                                Provider.of<Auth>(context,listen: false)
                                  ..logout();
                                  Navigator.pushReplacementNamed(context, 'mainscreen');
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
                'Add New Admin',
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

                      case 'Add New Admin':
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return AddAdminScreen();
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
