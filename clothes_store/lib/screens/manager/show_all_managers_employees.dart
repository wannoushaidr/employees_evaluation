import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/models/point_model.dart';
import 'package:clothes_store/screens/admin/add_accessory_screen.dart';
import 'package:clothes_store/screens/admin/show_all_points_screen.dart';
import 'package:clothes_store/screens/admin/update_branch_screen.dart';
import 'package:clothes_store/screens/admin/update_company_screen.dart';
import 'package:clothes_store/screens/admin/update_employee_screen.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:clothes_store/services/point_services.dart';
import 'package:flutter/material.dart';

// *******************************************   this is updataed code for above code ****************
import 'package:flutter/material.dart';

class showEmployeesByManages extends StatelessWidget {
  const showEmployeesByManages({super.key, required this.employees});
  final List<EmployeeModel?>? employees;

  @override
  Widget build(BuildContext context) {
    print("employees are ss :");
    print(employees);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees Data Table'),
        backgroundColor: const Color.fromARGB(255, 39, 95, 193),
        shadowColor: Colors.black,
        elevation: 2,
        //  automaticallyImplyLeading: MediaQuery.of(context).size.width <= 600,
      ),
      body: employees == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: const Color.fromARGB(255, 219, 219, 219),
              child: ListView(scrollDirection: Axis.horizontal, children: [
                Padding(
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
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Number',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Gender',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Position',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Active',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Branch ID',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'user ID',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'Leader ID',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        'more info ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      // DataColumn(label: Text('Actions')),
                    ],
                    rows: employees!.map((employee) {
                      return DataRow(cells: [
                        DataCell(Text(employee!.id.toString())),
                        DataCell(Text(employee.name)),
                        DataCell(Text(employee.description)),
                        DataCell(Text(employee.number.toString())),
                        DataCell(Text(employee.gender)),
                        DataCell(Text(employee.position)),
                        DataCell(Text(employee.active)),
                        DataCell(Text(employee.branch_id.toString())),
                        DataCell(Text(employee.user_id.toString())),
                        DataCell(Text(employee.leader_id != null
                            ? employee.leader_id.toString()
                            : '')),
                        // DataCell(Text("points")),

                        // DataCell(
                        //   Row(
                        //     children: [
                        //       IconButton(
                        //         icon: const Icon(Icons.details_outlined),
                        //         onPressed: () {
                        //           Navigator.push(context,
                        //               MaterialPageRoute(builder: (context) {
                        //             return UpdateEmployeeScreen(
                        //               employee: employee,
                        //             );
                        //           }));
                        //         },
                        //       ),

                        //     ],
                        //   ),
                        // ),

                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.details_outlined),
                                onPressed: () async {
                                  AppPointsService acp = AppPointsService();
                                  print(employee.id);
                                  List<PointModel?>? points =
                                      await acp.GetEmployeePoint(employee.id);
                                  if (points == null) {
                                    points = []; // Assign an empty list if null
                                  }
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ShowAllPointsScreen(points: points);
                                  }));
                                },
                              ),
                            ],
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ]),
            ),
    );
  }
}
