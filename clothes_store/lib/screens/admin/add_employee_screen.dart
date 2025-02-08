import 'dart:typed_data';

import 'package:clothes_store/helper/snackbar.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/company_services.dart';
import 'dart:html'
    as html; // Import the html library for web ************************************
import 'package:http/http.dart' as http;

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
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

  String name = '';
  String number = '';
  String description = '';
  String gender = '';
  String active = '';
  String position = '';
  String branch_id = '';
  String email = '';
  String? leader_id = '';
  Uint8List? image;
  String selectedFile = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
        backgroundColor: Colors.blueAccent,
        shadowColor: Colors.black,
        elevation: 2,
        // automaticallyImplyLeading: MediaQuery.of(context).size.width <= 600,
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
                      padding: EdgeInsets.only(top: 8),
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          email = value;
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          number = value;
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter description';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          description = value;
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
                        items: <String>['male', 'female'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            gender = newValue!;
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
                        items: <String>['true', 'false'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            active = newValue!;
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
                            position = newValue!;
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter branch id';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          branch_id = value;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Leader ID (optional)',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          leader_id = value.isNotEmpty ? value : null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'image',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (image == null) {
                            return 'Please upload an image';
                          }
                          return null;
                        },
                        readOnly: true, // Make it read-only
                        onTap: _pickImage,
                        controller: TextEditingController(
                            text: selectedFile.split('/').last),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ElevatedButton(
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
                            // Assuming you have a service to handle employee data
                            AppEmployeesService aes = AppEmployeesService();
                            bool? result = await aes.AddNewEmployee(
                              name: name,
                              email: email,
                              number: number,
                              description: description,
                              gender: gender,
                              position: position,
                              branch_id: branch_id,
                              leader_id: leader_id,
                              image: image!,
                              SelectedFile: selectedFile,
                              active: active,
                              //  user_id: '',
                            );
                            if (result == true) {
                              SnackbarShow.showSnackbar(
                                  context, "added succesfully");

                              print('Employee added successfully');
                              Navigator.pop(context);
                            } else {
                              SnackbarShow.showSnackbar(
                                  context,aes.message);

                              print('Error adding employee');
                            }
                          }
                        },
                        child: Text(
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
