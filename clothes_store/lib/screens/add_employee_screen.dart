import 'dart:typed_data';

import 'package:clothes_store/helper/snackbar.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:clothes_store/services/employee_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/company_services.dart';
import 'dart:html' as html; // Import the html library for web
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
  String? leader_id = '';
  Uint8List? image;
  String selectedFile = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      drawer: Drawer(
          child: ListView(children: [
            Row(children: [
              Container(
              height: 60,
              width: 60,
              child:ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset("images/screen.png",
                fit:BoxFit.cover,
              )),
              ),
              Expanded(
                child: ListTile(
                title: Text("user name"),
                subtitle: Text("email"),
              )
              )
            ],
            ),
            ListTile(
            leading:Icon(Icons.home),
              title:Container(  
            margin: EdgeInsets.symmetric(horizontal: 20),  
            child: MaterialButton(  
              // color: Colors.red,  
              textColor: Colors.black,  
              onPressed: () {  
                // Navigating to About Us page  
                Navigator.of(context).pushNamed('home');
              },  
              // leading:Icon(Icons.home),
              child: const Text("add new",textAlign: TextAlign.left,),  

            ),  
              )
            ),
            ListTile(
              leading:Icon(Icons.home),
              title:Container(  
            margin: EdgeInsets.symmetric(horizontal: 20),  
            child: MaterialButton(  
              // color: Colors.red,  
              textColor: Colors.black,  
              onPressed: () {  
                // Navigating to About Us page  
                Navigator.of(context).pushNamed('home');
              },  
              // leading:Icon(Icons.home),
              child: const Text("statistics",textAlign: TextAlign.left,),  

            ),  
              )
            ),
            ListTile(
             leading:Icon(Icons.home),
              title:Container(  
            margin: EdgeInsets.symmetric(horizontal: 20),  
            child: MaterialButton(  
              // color: Colors.red,  
              textColor: Colors.black,  
              onPressed: () {  
                // Navigating to About Us page  
                Navigator.of(context).pushNamed('showEmployees');
              },  
              // leading:Icon(Icons.home),
              child: const Text("employees",textAlign: TextAlign.left,),  

            ),  
              )
            ),
            ListTile(
              leading:Icon(Icons.home),
              title:Container(  
            margin: EdgeInsets.symmetric(horizontal: 20),  
            child: MaterialButton(  
              // color: Colors.red,  
              textColor: Colors.black,  
              onPressed: () {  
                // Navigating to About Us page  
                Navigator.of(context).pushNamed('showBranches');
              },  
              // leading:Icon(Icons.home),
              child: const Text("branches",textAlign: TextAlign.left,),  

            ),  
              )
            ),
            ListTile(
              leading:Icon(Icons.home),
              title:Container(  
            margin: EdgeInsets.symmetric(horizontal: 20),  
            child: MaterialButton(  
              // color: Colors.red,  
              textColor: Colors.black,  
              onPressed: () {  
                // Navigating to About Us page  
                Navigator.of(context).pushNamed('home');
              },  
              // leading:Icon(Icons.home),
              child: const Text("go to home",textAlign: TextAlign.left,),  

            ),  
              )
            )
          ],),
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
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Number'),
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
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
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
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Gender'),
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


                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'active'),
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



                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Position'),
                  items: <String>['manager', 'supervisor', 'customer_service']
                      .map((String value) {
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
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Branch ID'),
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
                SizedBox(height: 20),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Leader ID (optional)'),
                  onChanged: (value) {
                    leader_id = value.isNotEmpty ? value : null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'image'),
                  validator: (value) {
                    if (image == null) {
                      return 'Please upload an image';
                    }
                    return null;
                  },
                  readOnly: true, // Make it read-only
                  onTap: _pickImage,
                  controller:
                      TextEditingController(text: selectedFile.split('/').last),
                ),
                SizedBox(height: 20),
                ElevatedButton(
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
                        number: number,
                        description: description,
                        gender: gender,
                        position: position,
                        branch_id: branch_id,
                        leader_id: leader_id,
                        image: image!,
                        SelectedFile: selectedFile,
                         active: active,
                      );
                      if (result == true) {
                          SnackbarShow.showSnackbar(context, " added succesfully");

                        print('Employee added successfully');
                        Navigator.pop(context);
                      } else {
                         SnackbarShow.showSnackbar(context, " there is error");

                        print('Error adding employee');
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
