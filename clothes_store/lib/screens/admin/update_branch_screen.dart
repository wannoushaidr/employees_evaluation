import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/screens/admin/show_all_companies_screen.dart';
import 'package:flutter/material.dart';

import '../../services/branch_services.dart';
import '../../services/company_services.dart';

class UpdateBranchScreen extends StatefulWidget {
  UpdateBranchScreen({super.key, required this.branch});
  BranchModel? branch;

  @override
  State<UpdateBranchScreen> createState() => _UpdateBranchScreenState();
}

class _UpdateBranchScreenState extends State<UpdateBranchScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Branch'),
        backgroundColor: Colors.blueAccent,
        shadowColor: Colors.black,
        elevation: 2,
      ),
      body: Container(
        // color: Colors.white,
        color: const Color.fromARGB(255, 198, 196, 196),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Branch Name',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.branch!.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter branch name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          widget.branch!.name = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'phone',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.branch!.phone.toString(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter contact number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          widget.branch!.phone = int.parse(value);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'address',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.branch!.address.toString(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter number of branches';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          widget.branch!.address = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.branch!.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          widget.branch!.email = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'company_id',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.branch!.company_id.toString(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Address';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          widget.branch!.company_id = int.parse(value);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(500, 50),
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Process the data (e.g., send it to a server or save it locally)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          AppBranchesService abs = AppBranchesService();
                          bool? result = await abs.UpdateBranch(
                              id: widget.branch!.id.toString(),
                              name: widget.branch!.name,
                              phone: widget.branch!.phone.toString(),
                              address: widget.branch!.address,
                              email: widget.branch!.email,
                              company_id: widget.branch!.company_id.toString());
                          if (result == true) {
                            print('success');
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else {
                            print('error');
                          }
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
