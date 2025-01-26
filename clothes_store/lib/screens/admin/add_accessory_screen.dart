import 'dart:typed_data';

import 'package:clothes_store/helper/snackbar.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/company_services.dart';
import 'dart:html' as html; // Import the html library for web ********************
import 'package:http/http.dart' as http;

class AddAccessoryScreen extends StatefulWidget {
  const AddAccessoryScreen({super.key,required this.branch_id});
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
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Accessory Category'),
                items:
                    <String>['dressing_room', 'exit_door'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Update the selected category
                  setState(() {
                    type =
                        newValue!; // Make sure to define selectedCategory variable
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Accessory image'),
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
                    SnackbarShow.showSnackbar(context, "تتم المعالجة");
                    AppAccessoriesService aas = AppAccessoriesService();
                    bool? result = await aas.AddNewAccessory(
                        type: type,
                        image: image!,
                        SelectedFile: selectedFile,
                        branch_id: widget.branch_id);
                    if (result == true) {
                      print('success');
                      Navigator.pop(context);
                      SnackbarShow.showSnackbar(context, " added successfully");
                    } else {
                      SnackbarShow.showSnackbar(context, " there is error");
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
