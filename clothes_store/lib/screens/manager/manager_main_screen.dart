// import 'package:clothes_store/models/company_model.dart';
// import 'package:clothes_store/models/employee_model.dart';
// import 'package:clothes_store/screens/manager/show_all_managers_employees.dart';
// import 'package:clothes_store/screens/show_all_companies_screen.dart';
// import 'package:clothes_store/services/company_services.dart';
// import 'package:clothes_store/services/employee_services.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:clothes_store/services/auth.dart'; // Import your Auth class

// class ManagerMainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<Auth>(context);

//     return Scaffold(
//       appBar: AppBar(title: Text('managers main screen ')),

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
//               leading:Icon(Icons.home),
//               title:Container(  
//             margin: EdgeInsets.symmetric(horizontal: 20),  
//             child: MaterialButton(  
//               // color: Colors.red,  
//               textColor: Colors.black,  
//               onPressed: () {  
//                 // Navigating to About Us page  
//                 Navigator.of(context).pushNamed('statistics_screen');
//               },  
//               // leading:Icon(Icons.home),
//               child: const Text("statistics",textAlign: TextAlign.left,),  

//             ),  
//               )
//             ),
            
//           ]),
//          ),

// body: Center( 
//   child: Column( 
//     mainAxisAlignment: MainAxisAlignment.center,
//      children: <Widget>[ 
//     // CircleAvatar(
//     //    backgroundImage: NetworkImage(auth.user.avatar), radius: 50, ),
//         SizedBox(height: 10), Text('Name: ${auth.user.name}'),
//          SizedBox(height: 5), Text('Email: ${auth.user.email}'),
//           SizedBox(height: 5), Text('Role: ${auth.user.role}'),            
//              ElevatedButton( onPressed: () async { 
//               AppEmployeesService acp = AppEmployeesService();
//                List<EmployeeModel?>? employees = await acp.GetMyEmployeesEnformation(auth.user.id);
//                print(employees);
               
//                 if (employees != null) {
//                 Navigator.push( context, MaterialPageRoute(
//                   builder: (context) { 
//                     return showEmployeesByManages( 
//                       employees: employees ); 
//                       }
//                       ), 
//                       ); 
//                      }
//                       },
//                      child: Text('show employees by managers'),
//                       ),
//                        ], 
//                        ),
                       
//                         ), 
                        
//   );


//   }}




import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/models/point_model.dart';
import 'package:clothes_store/screens/manager/manager_statistics_screen.dart';
import 'package:clothes_store/screens/manager/show_all_managers_employees.dart';
import 'package:clothes_store/screens/show_all_companies_screen.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:clothes_store/services/company_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:clothes_store/services/point_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clothes_store/services/auth.dart'; // Import your Auth class

class ManagerMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Manager')),

      drawer: Drawer(
        child: ListView(
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      "images/screen.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text("User Name"),
                    subtitle: Text("Email"),
                  ),
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: MaterialButton(
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pushNamed('statistics_screen');
                  },
                  child: const Text(
                    "Statistics",
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
          ],
        ),
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
              child: Text('Show Employees by Managers'),
            ),

            ElevatedButton(
              onPressed: () async {
                // Your new button functionality goes here
                print('Second button pressed');
                AppPointsService aas = AppPointsService();
                        // List<PointModel?>? points = await aas.GetAllPoint();
                        AppEmployeesService aas3 = AppEmployeesService();
                          Map<String, int>? employeeCount = await aas3.getSupervisorsAndCustomerServiceEmployees(auth.user.id);

                if (employeeCount != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ManagerStatisticScreen(employeeCount: employeeCount, points: [],);
                      },
                    ),
                  );
                }
                // Example: Fetch another set of data or navigate to a different screen
              },
              child: Text('Second Button'),
            ),
          ],
        ),
      ),
    );
  }
}
