import 'package:clothes_store/helper/snackbar.dart';
import 'package:flutter/material.dart';

import '../../services/company_services.dart';
import 'package:clothes_store/utils/web_utils.dart'; // Updated import

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  _AddCompanyScreenState createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String number = '';
  String email = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Company'),
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
                          labelText: 'Company Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter company name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Contact Number',
                          border: OutlineInputBorder(),
                          
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter contact number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          number = value;
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Address';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          address = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(500, 50),
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Process the data (e.g., send it to a server or save it locally)
                            showAlert(context, 'Processing Data'); // Updated alert call

                            AppCompaniesService aps = AppCompaniesService();
                            bool? result = await aps.AddNewCompany(
                                name: name,
                                number: number,
                                email: email,
                                address: address);
                            if (result == true) {
                              print('success');
                              SnackbarShow.showSnackbar(
                                  context, "added successfully");

                              Navigator.pop(context);
                            } else {
                              SnackbarShow.showSnackbar(context, aps.message.toString());
                              print('error');
                            }
                          }
                        },
                        child: const Text(
                          'Submit', 
                          style: TextStyle(color: Colors.white),
                        ),
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
