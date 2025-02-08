import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/screens/admin/show_all_companies_screen.dart';
import 'package:flutter/material.dart';

import '../../services/company_services.dart';

class UpdateCompanyScreen extends StatefulWidget {
  UpdateCompanyScreen({super.key, required this.company});
  CompanyModel? company;

  @override
  State<UpdateCompanyScreen> createState() => _UpdateCompanyScreenState();
}

class _UpdateCompanyScreenState extends State<UpdateCompanyScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Company'),
        backgroundColor: Colors.blueAccent,
        shadowColor: Colors.black,
        elevation: 2,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Company Name',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.company!.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter company name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          widget.company!.name = value;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Contact Number',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.company!.number.toString(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter contact number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          widget.company!.number = int.parse(value);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.company!.email,
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
                          widget.company!.email = value;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.company!.address,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Address';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          widget.company!.address = value;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(500, 50),
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Process the data (e.g., send it to a server or save it locally)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')),
                          );
                          AppCompaniesService aps = AppCompaniesService();
                          bool? result = await aps.UpdateCompany(
                              id: widget.company!.id.toString(),
                              name: widget.company!.name,
                              number: widget.company!.number.toString(),
                              // number_of_branches:
                              // widget.company!.number_of_branch.toString(),
                              email: widget.company!.email,
                              address: widget.company!.address);
                          if (result == true) {
                            print('success');
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else {
                            print('error');
                          }
                        }
                      },
                      child: Text(
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
