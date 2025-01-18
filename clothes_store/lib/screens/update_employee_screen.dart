import 'dart:typed_data';

import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/company_services.dart';
import 'dart:html' as html; // Import the html library for web
import 'package:http/http.dart' as http;

class UpdateEmployeeScreen extends StatefulWidget {
  UpdateEmployeeScreen({super.key, required this.employee});
  EmployeeModel employee;
  @override
  _UpdateEmployeeScreenState createState() => _UpdateEmployeeScreenState();
}

class _UpdateEmployeeScreenState extends State<UpdateEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          image = result.files.single.bytes;
          selectedFile = result.files.single.name;
        });
      }
    } catch (e) {
      print('Error picking file: $e');
      // Handle error, e.g., show a dialog or message
    }
  }

  Uint8List? image;
  String? selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Employee'),
      ),

    
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  initialValue: widget.employee.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.employee.name = value;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Number'),
                  initialValue: widget.employee.number.toString(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.employee.number = int.parse(value);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  initialValue: widget.employee.description,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.employee.description = value;
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Gender'),
                  value: widget.employee.gender,
                  items: <String>['male', 'female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      widget.employee.gender = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a gender';
                    }
                    return null;
                  },
                ),



                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'active'),
                  value: widget.employee.active,
                  items: <String>['true', 'false'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      widget.employee.active = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a active';
                    }
                    return null;
                  },
                ),




                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Position'),
                  value: widget.employee.position,
                  items: <String>['manager', 'supervisor', 'customer_service']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      widget.employee.position = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a Position';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Branch ID'),
                  initialValue: widget.employee.branch_id.toString(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter branch id';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.employee.branch_id = int.parse(value);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Leader ID (optional)'),
                  initialValue: widget.employee.leader_id != null
                      ? widget.employee.leader_id.toString()
                      : '',
                  onChanged: (value) {
                    widget.employee.leader_id = int.parse(value);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'image (optional)'),
                  readOnly: true, // Make it read-only
                  onTap: _pickImage,
                  controller: TextEditingController(
                      text: selectedFile != null
                          ? selectedFile!.split('/').last
                          : ''),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Process the data (e.g., send it to a server or save it locally)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')),
                      );
                      print("after saving *****");
                      // Assuming you have a service to handle employee data
                      AppEmployeesService aes = AppEmployeesService();
                      bool? result = await aes.UpdateEmployee(
                        id: widget.employee.id.toString(),
                        name: widget.employee.name,
                        number: widget.employee.number.toString(),
                        description: widget.employee.description,
                        gender: widget.employee.gender,
                        position: widget.employee.position,
                        branch_id: widget.employee.branch_id.toString(),
                        leader_id: widget.employee.leader_id.toString(),
                        image: image,
                        active: widget.employee.active,
                      );
                      if (result == true) {
                        print('Employee Updated successfully');
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Employee Updated successfully')),);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        print('Error Updating employee');
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error Updating employee')),);
                      }
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
