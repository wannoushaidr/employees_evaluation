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
        title: Text('Update Branch'),
      ),



      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Branch Name'),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'phone'),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'address'),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                initialValue: widget.branch!.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.branch!.email = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'company_id'),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Process the data (e.g., send it to a server or save it locally)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')),
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
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
