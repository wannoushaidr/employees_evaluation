import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/models/point_model.dart';
import 'package:clothes_store/screens/add_accessory_screen.dart';
import 'package:clothes_store/screens/show_all_points_screen.dart';
import 'package:clothes_store/screens/update_branch_screen.dart';
import 'package:clothes_store/screens/update_company_screen.dart';
import 'package:clothes_store/screens/update_employee_screen.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:clothes_store/services/point_services.dart';
import 'package:flutter/material.dart';



// *******************************************   this is updataed code for above code ****************
import 'package:flutter/material.dart';

class showActivateEmployees extends StatelessWidget {
  const showActivateEmployees( {super.key, required this.employees});
  final List<EmployeeModel?>? employees;
  

  @override
  Widget build(BuildContext context) {
    print("employees are ss :");
      print(employees);

    return Scaffold(
      appBar: AppBar(
        title: const Text('activated employees  Data Table'),
      ),

      body: employees == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Number')),
                  DataColumn(label: Text('Gender')),
                  DataColumn(label: Text('Position')),
                  DataColumn(label: Text('Active')),
                  DataColumn(label: Text('Branch ID')),
                   DataColumn(label: Text('user ID')),
                   DataColumn(label: Text('Leader ID')),
                  DataColumn(label: Text('more info ')),
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
                    DataCell(Text(employee.leader_id != null ? employee.leader_id.toString() : '')),
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
                                    List<PointModel?>? points= await acp.GetEmployeePoint(employee.id);  
                                    if (points == null) {  
                                          points = []; // Assign an empty list if null  
                                        }  
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {  
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
    );
  }
}
