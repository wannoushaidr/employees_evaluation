import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/screens/admin/add_accessory_screen.dart';
import 'package:clothes_store/screens/admin/update_branch_screen.dart';
import 'package:clothes_store/screens/admin/update_company_screen.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:flutter/material.dart';

import '../../services/company_services.dart';

class ShowAllBranchesScreen extends StatelessWidget {
  const ShowAllBranchesScreen({super.key, required this.branches});
  final List<BranchModel?>? branches;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Branch Data Table'),
        backgroundColor: const Color.fromARGB(255, 39, 95, 193),
        shadowColor: Colors.black,
        elevation: 2,
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

      body: Container(
        color: const Color.fromARGB(255, 219, 219, 219),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 186, 184, 184)),
                    dataRowColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 255, 255, 255)),
                    columns: const [
                      DataColumn(
                          label: Text(
                        'ID',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'phone',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'address',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Email',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Actions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
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
                                    return AddAccessoryScreen(
                                      branch_id: branch.id.toString(),
                                    );
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
                                  AppBranchesService acp =
                                      new AppBranchesService();

                                  bool? result = await acp.DeleteBranch(
                                      id: branch.id.toString());
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
