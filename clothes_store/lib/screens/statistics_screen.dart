

import 'package:clothes_store/models/accessory_model.dart';
import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/point_model.dart';
import 'package:clothes_store/screens/update_accessory_screen.dart';
import 'package:clothes_store/screens/update_branch_screen.dart';
import 'package:clothes_store/screens/update_company_screen.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:clothes_store/services/point_services.dart';
import 'package:flutter/material.dart';

import '../services/company_services.dart';

class statistics_screen extends StatelessWidget {
  const statistics_screen({super.key,   required this.branchesCount, required this.points,  required this.employeeCount});
  final int  branchesCount;
  final List<int?> points;
  final Map<String, int> employeeCount;


  @override
  Widget build(BuildContext context) {
  int totalPoints = points.fold(0, (previous, current) => previous + (current ?? 0));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessories Data Table'),
      ),


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
      //       leading:Icon(Icons.home),
      //         title:Container(  
      //       margin: EdgeInsets.symmetric(horizontal: 20),  
      //       child: MaterialButton(  
      //         // color: Colors.red,  
      //         textColor: Colors.black,  
      //         onPressed: () {  
      //           // Navigating to About Us page  
      //           Navigator.of(context).pushNamed('home');
      //         },  
      //         // leading:Icon(Icons.home),
      //         child: const Text("add new",textAlign: TextAlign.left,),  

      //       ),  
      //         )
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
      //       ListTile(
      //        leading:Icon(Icons.home),
      //         title:Container(  
      //       margin: EdgeInsets.symmetric(horizontal: 20),  
      //       child: MaterialButton(  
      //         // color: Colors.red,  
      //         textColor: Colors.black,  
      //         onPressed: () {  
      //           // Navigating to About Us page  
      //           Navigator.of(context).pushNamed('showEmployees');
      //         },  
      //         // leading:Icon(Icons.home),
      //         child: const Text("employees",textAlign: TextAlign.left,),  

      //       ),  
      //         )
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
      //           Navigator.of(context).pushNamed('showBranches');
      //         },  
      //         // leading:Icon(Icons.home),
      //         child: const Text("branches",textAlign: TextAlign.left,),  

      //       ),  
      //         )
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
      //           Navigator.of(context).pushNamed('home');
      //         },  
      //         // leading:Icon(Icons.home),
      //         child: const Text("go to home",textAlign: TextAlign.left,),  

      //       ),  
      //         )
      //       )
      //     ],),
      //    ),

    
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Branches Count: $branchesCount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text('Points:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(totalPoints.toString()),
              const SizedBox(height: 16),
              Text('Employee Statistics:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Employee Count: ${employeeCount['employee_count']}'),
              Text('Customer Service Count: ${employeeCount['customer_service_count']}'),
              Text('Manager Count: ${employeeCount['manager_count']}'),
              Text('Supervisor Count: ${employeeCount['supervisor_count']}'),
            ],
          ),
        ),
      ),
    );
  }
}

      
     
      
