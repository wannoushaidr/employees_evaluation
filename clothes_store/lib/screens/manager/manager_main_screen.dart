import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/screens/login_screen.dart';
import 'package:clothes_store/screens/manager/show_all_managers_employees.dart';
import 'package:clothes_store/screens/show_all_companies_screen.dart';
import 'package:clothes_store/services/company_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clothes_store/services/auth.dart'; // Import your Auth class

class ManagerMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return Scaffold(
      appBar: AppBar(title: Text('manager main screen ')),

      // drawer: Drawer(
      //     child: ListView(children: [
      //       Row(children: [
      //         Container(
      //         height: 60,
      //         width: 60,
      //         child:ClipRRect(
      //           borderRadius: BorderRadius.circular(60),
      //           child: Image.asset("images/screen.png",
      //           fit:BoxFit.cover,
      //         )),
      //         ),
      //         Expanded(
      //           child: ListTile(
      //           title: Text("user name"),
      //           subtitle: Text("email"),
      //         )
      //         )
      //       ],
      //       ),
            
      //       ListTile(
      //         leading:Icon(Icons.home),
      //         title:Container(  
      //       margin: EdgeInsets.symmetric(horizontal: 20),  
      //       child: MaterialButton(  
      //         // color: Colors.red,  
      //         textColor: Colors.black,  
      //         onPressed: () {  
      //           // Navigating to About Us page  
      //           Navigator.of(context).pushNamed('statistics_screen');
      //         },  
      //         // leading:Icon(Icons.home),
      //         child: const Text("statistics",textAlign: TextAlign.left,),  

      //       ),  
      //         )
      //       ),
            
      //     ]),
      //    ),

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
                                Navigator.of(context).pushNamed('manager_mainScreen');
                              },  
                              // leading:Icon(Icons.home),
                              child: const Text("go to home",textAlign: TextAlign.left,),  

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

body: Center( 
  child: Column( 
    mainAxisAlignment: MainAxisAlignment.center,
     children: <Widget>[ 
    // CircleAvatar(
    //    backgroundImage: NetworkImage(auth.user.avatar), radius: 50, ),
        SizedBox(height: 10), Text('Name: ${auth.user.name}'),
         SizedBox(height: 5), Text('Email: ${auth.user.email}'),
          SizedBox(height: 5), Text('Role: ${auth.user.role}'),
            SizedBox(height: 20),
             ElevatedButton( onPressed: () async { 
              AppEmployeesService acp = AppEmployeesService();
               List<EmployeeModel?>? employees = await acp.GetMyEmployeesEnformation(auth.user.id);
               print("employees are :");
               print(employees);
               
                if (employees != null) {
                Navigator.push( context, MaterialPageRoute(
                  builder: (context) { 
                    return showEmployeesByManages( 
                      employees: employees ); 
                      }
                      ), 
                      ); 
                     }
                      },
                     child: Text('show employees by managers'),
                      ),
                       ], 
                       ),
                       
                        ), 
                        
      );


      }}