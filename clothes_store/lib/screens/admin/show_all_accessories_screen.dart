import 'package:clothes_store/models/accessory_model.dart';
import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/screens/admin/update_accessory_screen.dart';
import 'package:clothes_store/screens/admin/update_branch_screen.dart';
import 'package:clothes_store/screens/admin/update_company_screen.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:flutter/material.dart';

import '../../services/company_services.dart';

class ShowAllAccessoriesScreen extends StatelessWidget {
  const ShowAllAccessoriesScreen({super.key, required this.accessories});
  final List<AccessoryModel?>? accessories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accessories Data Table'),
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
                        'Type',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'branch_id',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'created_at',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'updated_at',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Actions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ],
                    rows: accessories!.map((accessory) {
                      return DataRow(cells: [
                        DataCell(Text(accessory!.id.toString())),
                        DataCell(Text(accessory.type)),
                        DataCell(Text(accessory.branch_id.toString())),
                        DataCell(Text(accessory.created_at)),
                        DataCell(Text(accessory.updated_at)),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return UpdateAccessoryScreen(
                                      accessory: accessory,
                                    );
                                  }));
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  AppAccessoriesService aas =
                                      new AppAccessoriesService();
                                  bool? result = await aas.DeleteAccessory(
                                      id: accessory.id.toString());
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
