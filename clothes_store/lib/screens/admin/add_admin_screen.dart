import 'dart:typed_data';

import 'package:clothes_store/helper/snackbar.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:clothes_store/services/user_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/company_services.dart';
import 'dart:html' as html; // Import the html library for web
import 'package:http/http.dart' as http;

class AddAdminScreen extends StatefulWidget {
  @override
  _AddAdminScreen createState() => _AddAdminScreen();
}

class _AddAdminScreen extends State<AddAdminScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      // if (result != null && result.files.isNotEmpty) {
      //   setState(() {
      //     image = result.files.single.bytes;
      //     selectedFile = result.files.single.name;
      //   });
      // }
    } catch (e) {
      print('Error picking file: $e');
      // Handle error, e.g., show a dialog or message
    }
  }

  String name = '';
  // String number = '';
  // String gender = '';
  String role = '';
  String email = '';
  String password = '';
  // Uint8List? image;
  // String selectedFile = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add admin screen'),
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
                          labelText: 'password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),

                    // SizedBox(height: 20),
                    // TextFormField(
                    //   decoration: InputDecoration(labelText: 'Number'),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter number';
                    //     }
                    //     return null;
                    //   },
                    //   onChanged: (value) {
                    //     number = value;
                    //   },
                    // ),

                    // SizedBox(height: 20),
                    // DropdownButtonFormField<String>(
                    //   decoration: InputDecoration(labelText: 'Gender'),
                    //   items: <String>['male', 'female'].map((String value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value,
                    //       child: Text(value),
                    //     );
                    //   }).toList(),
                    //   onChanged: (String? newValue) {
                    //     setState(() {
                    //       gender = newValue!;
                    //     });
                    //   },
                    //   validator: (value) {
                    //     if (value == null) {
                    //       return 'Please select a gender';
                    //     }
                    //     return null;
                    //   },
                    // ),

                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'role',
                          border: OutlineInputBorder(),
                        ),
                        items: <String>['admin'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            role = newValue!;
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
                          // Assuming you have a service to handle employee data
                          AppUsersService aes = AppUsersService();
                          bool? result = await aes.SetNewAdmin(
                              name: name,
                              email: email,
                              // number: number,
                              // gender: gender,
                              role: role,
                              password: password
                              // image: image!,
                              // SelectedFile: selectedFile,
                              );
                          if (result == true) {
                            SnackbarShow.showSnackbar(
                                context, " added succesfully");

                            print('Employee added successfully');
                            Navigator.pop(context);
                          } else {
                            SnackbarShow.showSnackbar(
                                context, " there is error");

                            print('Error adding employee');
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
