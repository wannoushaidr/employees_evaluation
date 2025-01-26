import 'dart:typed_data';

import 'package:clothes_store/models/employee_model.dart';
import 'package:clothes_store/models/user.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:clothes_store/services/user_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/company_services.dart';
import 'dart:html' as html; // Import the html library for web /********************** */
import 'package:http/http.dart' as http;

class UpdateAdminScreen extends StatefulWidget {
  UpdateAdminScreen({super.key, required this.admins});
  UserModel admins;
  @override
  _UpdateAdminScreen createState() => _UpdateAdminScreen();
}

class _UpdateAdminScreen extends State<UpdateAdminScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    print("sssss");
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          // image = result.files.single.bytes;
          // selectedFile = result.files.single.name;
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
                
                 SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  initialValue: widget.admins.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.admins.name = value;
                  },
                ),

                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'email'),
                  initialValue: widget.admins.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.admins.email = value;
                  },
                ),


                // SizedBox(height: 20),
                // TextFormField(
                //   decoration: InputDecoration(labelText: 'Number'),
                //   initialValue: widget.employee.number.toString(),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter number';
                //     }
                //     return null;
                //   },
                //   onChanged: (value) {
                //     widget.employee.number = int.parse(value);
                //   },
                // ),
                
                // SizedBox(height: 20),
                // DropdownButtonFormField<String>(
                //   decoration: InputDecoration(labelText: 'Gender'),
                //   value: widget.employee.gender,
                //   items: <String>['male', 'female'].map((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       widget.employee.gender = newValue!;
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
                TextFormField(
                  decoration: InputDecoration(labelText: 'role'),
                  initialValue: widget.admins.role,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.admins.role = widget.admins.role;
                  },
                ),

                

                
                // SizedBox(height: 20),
                // TextFormField(
                //   decoration: InputDecoration(labelText: 'image (optional)'),
                //   readOnly: true, // Make it read-only
                //   onTap: _pickImage,
                //   controller: TextEditingController(
                //       text: selectedFile != null
                //           ? selectedFile!.split('/').last
                //           : ''),
                // ),


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
                      AppUsersService aes = AppUsersService();
                      bool? result = await aes.UpdateAdmin(
                        id: widget.admins.id.toString(),
                        name: widget.admins.name,
                        // number: widget.employee.number.toString(),
                        // gender: widget.employee.gender,
                        role: widget.admins.role,
                        email: widget.admins.email,
                        // image: image,
                        
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
