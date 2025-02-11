import 'dart:typed_data';

import 'package:clothes_store/helper/snackbar.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/company_services.dart';
import 'package:clothes_store/utils/web_utils.dart'; // Updated import
import 'package:http/http.dart' as http;

class AddAccessoryScreen extends StatefulWidget {
  const AddAccessoryScreen({super.key, required this.branch_id});
  final String branch_id;
  @override
  _AddAccessoryScreenState createState() => _AddAccessoryScreenState();
}

class _AddAccessoryScreenState extends State<AddAccessoryScreen> {
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

  String selectedFile = '';
  Uint8List? image;
  String type = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Accessory'),
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
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Accessory Category',
                          border: OutlineInputBorder(),
                        ),
                        items: <String>['dressing_room', 'exit_door']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            type = newValue!;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a category';
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
                          labelText: 'Accessory image',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (image == null) {
                            return 'Please upload an image';
                          }
                          return null;
                        },
                        readOnly: true,
                        onTap: _pickImage,
                        controller: TextEditingController(
                            text: selectedFile.split('/').last),
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
                          showAlert(context, 'Processing Data'); // Updated alert call

                          AppAccessoriesService aas = AppAccessoriesService();
                          bool? result = await aas.AddNewAccessory(
                              type: type,
                              image: image!,
                              SelectedFile: selectedFile,
                              branch_id: widget.branch_id);
                          if (result == true) {
                            print('success');
                            Navigator.pop(context);
                            SnackbarShow.showSnackbar(
                                context, "added successfully");
                          } else {
                            SnackbarShow.showSnackbar(
                                context, "there is error");
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
