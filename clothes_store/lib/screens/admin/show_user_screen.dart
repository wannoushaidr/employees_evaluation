

import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/models/user.dart';
import 'package:clothes_store/screens/admin/add_accessory_screen.dart';
import 'package:clothes_store/screens/admin/update_admin_screen.dart';
import 'package:clothes_store/screens/admin/update_branch_screen.dart';
import 'package:clothes_store/screens/admin/update_company_screen.dart';
import 'package:clothes_store/screens/admin/update_employee_screen.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:clothes_store/services/user_services.dart';
import 'package:flutter/material.dart';

import '../../services/company_services.dart';



// *******************************************   this is updataed code for above code ****************
import 'package:flutter/material.dart';

class ShowAllUsersScreen extends StatelessWidget {
  const ShowAllUsersScreen({super.key, this.users});
  final List<UserModel?>? users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees Data Table'),
      ),


     
      body: users == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Name')),
                  // DataColumn(label: Text('Number')),
                  // DataColumn(label: Text('Gender')),
                  DataColumn(label: Text('role')),
                  
                  DataColumn(label: Text('email')),
                  DataColumn(label: Text('Actions')),
                  

                ],
                rows: users!.map((users) {
                  return DataRow(cells: [
                    DataCell(Text(users!.id.toString())),
                    DataCell(Text(users.name)),
                    // DataCell(Text(employee.number.toString())),
                    // DataCell(Text(employee.gender)),
                    DataCell(Text(users.role)),
                    DataCell(Text(users.email)),


                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return UpdateAdminScreen(
                                   admins: users,
                                );
                              }));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              AppUsersService aes = AppUsersService();
                              bool? result = await aes.DeleteAdmin(id: users.id.toString());
                              if (result == true) {
                                print('Success');
                                Navigator.pop(context);
                              } else {
                                print('Error');
                              }
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
