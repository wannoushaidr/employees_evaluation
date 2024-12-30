import 'package:clothes_store/helper/snackbar.dart';
import 'package:flutter/material.dart';

import '../services/company_services.dart';

class AddCompanyScreen extends StatefulWidget {
  @override
  _AddCompanyScreenState createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String number = '';
  String numberOfBranches = '';
  String email = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Company'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Company Name'),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Number'),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Number of Branches'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter number of branches';
                  }
                  return null;
                },
                onChanged: (value) {
                  numberOfBranches = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Process the data (e.g., send it to a server or save it locally)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')),
                    );
                    AppCompaniesService aps = AppCompaniesService();
                    bool? result = await aps.AddNewCompany(
                        name: name,
                        number: number,
                        number_of_branches: numberOfBranches,
                        email: email,
                        address: address);
                    if (result == true) {
                      print('success');
                      SnackbarShow.showSnackbar(context, "added successfully  ");

                      Navigator.pop(context);
                    } else {
                      SnackbarShow.showSnackbar(context, " error ");
                      print('error');
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
