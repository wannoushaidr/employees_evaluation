import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/point_model.dart';
import 'package:clothes_store/screens/admin/add_branch_screen.dart';
import 'package:clothes_store/screens/admin/show_all_branches_screen.dart';
import 'package:clothes_store/screens/admin/update_company_screen.dart';
import 'package:clothes_store/services/point_services.dart';
import 'package:flutter/material.dart';

import '../../services/branch_services.dart';
import '../../services/company_services.dart';

class ShowAllPointsScreen extends StatelessWidget {
  const ShowAllPointsScreen({super.key, required this.points});
  final List<PointModel?>? points;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('points Data Table'),
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
                    headingRowColor: WidgetStateProperty.all(
                        const Color.fromARGB(255, 186, 184, 184)),
                    dataRowColor: WidgetStateProperty.all(
                        const Color.fromARGB(255, 255, 255, 255)),
                    columns: const [
                      DataColumn(
                          label: Text(
                        'ID',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'points_count',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'description',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'employee_id',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Actions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ],
                    rows: points!.map((point) {
                      return DataRow(cells: <DataCell>[
                        DataCell(Text(point!.id.toString())),
                        DataCell(Text(point.points_count.toString())),
                        DataCell(Text(point.description)),
                        // DataCell(Text(point.description)),
                        DataCell(Text(point.employee_id.toString())),
                        DataCell(
                          Row(
                            children: [
                              // IconButton(
                              //   icon: const Icon(Icons.ad_units),
                              //   onPressed: () async {
                              //     AppBranchesService abs = AppBranchesService();
                              //     List<BranchModel?>? branches =
                              //         await abs.GetAllBranches();
                              //     print(branches);
                              //     Navigator.push(context,
                              //         MaterialPageRoute(builder: (context) {
                              //       return ShowAllBranchesScreen(
                              //         branches: branches,
                              //       );
                              //     }));
                              //   },
                              // ),
                              // IconButton(
                              //   icon: const Icon(Icons.add),
                              //   onPressed: () {
                              //     Navigator.push(context,
                              //         MaterialPageRoute(builder: (context) {
                              //       return AddBranchScreen(
                              //         company_id: company.id.toString(),
                              //       );
                              //     }));
                              //   },
                              // ),
                              // IconButton(
                              //   icon: const Icon(Icons.edit),
                              //   onPressed: () {
                              //     Navigator.push(context,
                              //         MaterialPageRoute(builder: (context) {
                              //       return UpdateCompanyScreen(
                              //         company: company,
                              //       );
                              //     }));
                              //   },
                              // ),

                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  AppPointsService acp = AppPointsService();
                                  bool? result = await acp.DeletePoint(
                                      id: point.id.toString());
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
