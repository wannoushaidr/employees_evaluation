import 'dart:typed_data';

import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/models/user.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/company_services.dart';

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
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
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
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        initialValue: widget.employee.email,
                        decoration: InputDecoration(
                          labelText: 'email',
                          border: OutlineInputBorder(),
                        ),
                        // initialValue: widget.employee.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          widget.employee.email = value;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Number',
                          border: OutlineInputBorder(),
                        ),
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
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
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
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          border: OutlineInputBorder(),
                        ),
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
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'active',
                          border: OutlineInputBorder(),
                        ),
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
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Position',
                          border: OutlineInputBorder(),
                        ),
                        value: widget.employee.position,
                        items: <String>[
                          'manager',
                          'supervisor',
                          'customer_service'
                        ].map((String value) {
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
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Branch ID',
                          border: OutlineInputBorder(),
                        ),
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
                    ),
                    SizedBox(height: 20),
                    // Container(
                    //   width: 500,
                    //   child: TextFormField(
                    //     decoration: InputDecoration(
                    //       labelText: 'user ID',
                    //       border: OutlineInputBorder(),
                    //     ),
                    //     initialValue: widget.employee.user_id.toString(),
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return 'Please enter user_id ';
                    //       }
                    //       return null;
                    //     },
                    //     onChanged: (value) {
                    //       widget.employee.user_id = int.parse(value);
                    //     },
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Leader ID (optional)',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: widget.employee.leader_id != null
                            ? widget.employee.leader_id.toString()
                            : '',
                        onChanged: (value) {
                          widget.employee.leader_id = int.parse(value);
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'image (optional)',
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true, // Make it read-only
                        onTap: _pickImage,
                        controller: TextEditingController(
                            text: selectedFile != null
                                ? selectedFile!.split('/').last
                                : ''),
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
                            email: widget.employee.email,
                            branch_id: widget.employee.branch_id.toString(),
                            leader_id: widget.employee.leader_id.toString(),
                            image: image,
                            active: widget.employee.active,
                            user_id: widget.employee.user_id.toString(),
                          );
                          if (result == true) {
                            print('Employee Updated successfully');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Employee Updated successfully')),
                            );
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else {
                            print('Error Updating employee');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Error Updating employee')),
                            );
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
