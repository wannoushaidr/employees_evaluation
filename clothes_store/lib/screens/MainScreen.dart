import 'dart:typed_data';

import 'package:clothes_store/models/accessory_model.dart';
import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/screens/login_screen.dart';
import 'package:clothes_store/screens/show_all_companies_screen.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:clothes_store/services/auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/branch_services.dart';
import '../services/company_services.dart';

class MainScreen extends StatefulWidget {
  
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Main screen'),
      // ),
        appBar: AppBar( 
        centerTitle: true,
        
        // shadow
        elevation: 20.0,
        shadowColor: Colors.red,
         title: const Text(  "Main screen",   ),  
          titleTextStyle: TextStyle(color: Colors.blue), 
         backgroundColor: Colors.amber,
         
         ),

        // طبعا ال drawer بتظهر داخل ال appBar  واذا ما عندي appBar بأنشأ فوق      GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();

        //   // وهي عكس ال dawer وبتطلع الايقونة من الطرف التاني
        //  endDrawer: Drawer(),
        //  drawer
        // drawer: Drawer(
        //   child: ListView(children: [
        //     Row(children: [
        //       Container(
        //       height: 60,
        //       width: 60,
        //       child:ClipRRect(
        //         borderRadius: BorderRadius.circular(60),
        //         child: Image.asset("images/screen.png",
        //         fit:BoxFit.cover,
        //       )),
        //       ),
        //       Expanded(
        //         child: ListTile(
        //         title: Text("user name"),
        //         subtitle: Text("email"),
        //       )
        //       )
        //     ],
        //     ),
        //     ListTile(
        //     leading:Icon(Icons.home),
        //       title:Container(  
        //     margin: EdgeInsets.symmetric(horizontal: 20),  
        //     child: MaterialButton(  
        //       // color: Colors.red,  
        //       textColor: Colors.black,  
        //       onPressed: () {  
        //         // Navigating to About Us page  
        //         Navigator.of(context).pushNamed('home');
        //       },  
        //       // leading:Icon(Icons.home),
        //       child: const Text("add new",textAlign: TextAlign.left,),  

        //     ),  
        //       )
        //     ),
        //     ListTile(
        //       leading:Icon(Icons.home),
        //       title:Container(  
        //     margin: EdgeInsets.symmetric(horizontal: 20),  
        //     child: MaterialButton(  
        //       // color: Colors.red,  
        //       textColor: Colors.black,  
        //       onPressed: () {  
        //         // Navigating to About Us page  
        //         Navigator.of(context).pushNamed('statistics_screen');
        //       },  
        //       // leading:Icon(Icons.home),
        //       child: const Text("statistics",textAlign: TextAlign.left,),  

        //     ),  
        //       )
        //     ),
        //     ListTile(
        //      leading:Icon(Icons.home),
        //       title:Container(  
        //     margin: EdgeInsets.symmetric(horizontal: 20),  
        //     child: MaterialButton(  
        //       // color: Colors.red,  
        //       textColor: Colors.black,  
        //       onPressed: () {  
        //         // Navigating to About Us page  
        //         Navigator.of(context).pushNamed('showEmployees');
        //       },  
        //       // leading:Icon(Icons.home),
        //       child: const Text("employees",textAlign: TextAlign.left,),  

        //     ),  
        //       )
        //     ),
        //     ListTile(
        //       leading:Icon(Icons.home),
        //       title:Container(  
        //     margin: EdgeInsets.symmetric(horizontal: 20),  
        //     child: MaterialButton(  
        //       // color: Colors.red,  
        //       textColor: Colors.black,  
        //       onPressed: () {  
        //         // Navigating to About Us page  
        //         Navigator.of(context).pushNamed('showBranches');
        //       },  
        //       // leading:Icon(Icons.home),
        //       child: const Text("branches",textAlign: TextAlign.left,),  

        //     ),  
        //       )
        //     ),
        //     ListTile(
        //       leading:Icon(Icons.home),
        //       title:Container(  
        //     margin: EdgeInsets.symmetric(horizontal: 20),  
        //     child: MaterialButton(  
        //       // color: Colors.red,  
        //       textColor: Colors.black,  
        //       onPressed: () {  
        //         // Navigating to About Us page  
        //         Navigator.of(context).pushNamed('home');
        //       },  
        //       // leading:Icon(Icons.home),
        //       child: const Text("go to home",textAlign: TextAlign.left,),  

        //     ),  
        //       )
        //     )
        //   ],),
        //  ),

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
                              child: const Text("home",textAlign: TextAlign.left,),  

                            ),  
                              )
                            ),

                           
                          
                          ListTile(
                              leading:const Icon(Icons.logout),
                              title:const Text("logout"),
                              onTap: (){
                                Provider.of<Auth>(context,listen: false)
                                  ..logout();
                                  Navigator.of(context).pushNamed('mainscreen');
                              },
                            ),
                            
                          ],
                          );
                            }
                      }) 
                      ),


      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

             
            ],
          ),
        ),
      ),
    );
  }
}
