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
        backgroundColor: const Color.fromARGB(255, 39, 95, 193),
        shadowColor: Colors.black,
        elevation: 2,
      ),
      body: users == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              // color: const Color.fromARGB(255, 219, 219, 219),
              color: const Color.fromARGB(255, 198, 196, 196),
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
                              // const Color.fromARGB(255, 255, 255, 255)),
                              const Color.fromARGB(255, 177, 174, 174)),
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
                            // DataColumn(label: Text('Number')),
                            // DataColumn(label: Text('Gender')),
                            DataColumn(
                                label: Text(
                              'role',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),

                            DataColumn(
                                label: Text(
                              'email',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                            DataColumn(
                                label: Text(
                              'Actions',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
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
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return UpdateAdminScreen(
                                            admins: users,
                                          );
                                        }));
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,color: Color.fromARGB(255, 181, 57, 53)),
                                      onPressed: () async {
                                        AppUsersService aes = AppUsersService();
                                        bool? result = await aes.DeleteAdmin(
                                            id: users.id.toString());
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
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
