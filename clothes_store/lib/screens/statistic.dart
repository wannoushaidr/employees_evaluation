

import 'package:clothes_store/models/accessory_model.dart';
import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/screens/update_accessory_screen.dart';
import 'package:clothes_store/screens/update_branch_screen.dart';
import 'package:clothes_store/screens/update_company_screen.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:flutter/material.dart';

import '../services/company_services.dart';

class statistic extends StatelessWidget {
  const statistic({super.key, required this.accessories, required accessory});
  final List<AccessoryModel?>? accessories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessories Data Table'),
      ),
      drawer: Drawer(
          child: ListView(children: [
            Row(children: [
              Container(
              height: 60,
              width: 60,
              child:ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset("images/screen.png",
                fit:BoxFit.cover,
              )),
              ),
              Expanded(
                child: ListTile(
                title: Text("user name"),
                subtitle: Text("email"),
              )
              )
            ],
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
                Navigator.of(context).pushNamed('home');
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
            )
          ],),
         ),
      body: SingleChildScrollView(
        child: Text("statix"),
        // child: DataTable(
        //   columns: const [
        //     DataColumn(label: Text('ID')),
        //     DataColumn(label: Text('Type')),
        //     DataColumn(label: Text('branch_id')),
        //     DataColumn(label: Text('created_at')),
        //     DataColumn(label: Text('updated_at')),
        //     DataColumn(label: Text('Actions')),
        //   ],
        //   rows: accessories!.map((accessory) {
        //     return DataRow(cells: [
        //       DataCell(Text(accessory!.id.toString())),
        //       DataCell(Text(accessory.type)),
        //       DataCell(Text(accessory.branch_id.toString())),
        //       DataCell(Text(accessory.created_at)),
        //       DataCell(Text(accessory.updated_at)),
        //       DataCell(
        //         Row(
        //           children: [
        //             IconButton(
        //               icon: const Icon(Icons.edit),
        //               onPressed: () {
        //                 Navigator.push(context,
        //                     MaterialPageRoute(builder: (context) {
        //                   return UpdateAccessoryScreen(
        //                     accessory: accessory,
        //                   );
        //                 }));
        //               },
        //             ),
        //             IconButton(
        //               icon: const Icon(Icons.delete),
        //               onPressed: () async {
        //                 AppAccessoriesService aas = new AppAccessoriesService();
        //                 bool? result = await aas.DeleteAccessory(
        //                     id: accessory.id.toString());
        //                 if (result == true) {
        //                   print('success');
        //                   Navigator.pop(context);
        //                 } else {
        //                   print('error');
        //                 }
        //                 // Navigator.push(context,
        //                 //     MaterialPageRoute(builder: (context) {
        //                 //   return UpdateCompanyScreen(
        //                 //     company: company,
        //                 //   );
        //                 // }));
        //               },
        //             ),
        //           ],
        //         ),
        //       ),
        //     ]);
        //   }).toList(),


        // ),
      ),
    );
  }
}
