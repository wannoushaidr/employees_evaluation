import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/screens/add_accessory_screen.dart';
import 'package:clothes_store/screens/update_branch_screen.dart';
import 'package:clothes_store/screens/update_company_screen.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:flutter/material.dart';

import '../services/company_services.dart';

class ShowAllBranchesScreen extends StatelessWidget {
  const ShowAllBranchesScreen({super.key, required this.branches});
  final List<BranchModel?>? branches;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Branch Data Table'),
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
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('phone')),
            DataColumn(label: Text('address')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Actions')),
          ],
          rows: branches!.map((branch) {
            return DataRow(cells: [
              DataCell(Text(branch!.id.toString())),
              DataCell(Text(branch.name)),
              // DataCell(Text(branch.phone)),
              DataCell(Text(branch.phone.toString())),
              DataCell(Text(branch.address)),
              DataCell(Text(branch.email)),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return AddAccessoryScreen(branch_id: branch.id.toString(),);
                        }));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return UpdateBranchScreen(
                            branch: branch,
                          );
                        }));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        AppBranchesService acp = new AppBranchesService();
                        
                        bool? result =
                            await acp.DeleteBranch(id: branch.id.toString());
                        if (result == true) {
                          print('success');
                          Navigator.pop(context);
                        } else {
                          print('error');
                        }
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return UpdateCompanyScreen(
                        //     company: company,
                        //   );
                        // }));
                      },
                    ),
                  ],
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
