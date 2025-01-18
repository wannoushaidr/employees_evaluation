import 'dart:typed_data';

import 'package:clothes_store/models/accessory_model.dart';
import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/screens/show_all_companies_screen.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../services/branch_services.dart';
import '../services/company_services.dart';

class UpdateAccessoryScreen extends StatefulWidget {
  UpdateAccessoryScreen({super.key, required this.accessory});
  AccessoryModel? accessory;

  @override
  State<UpdateAccessoryScreen> createState() => _UpdateAccessoryScreenState();
}

class _UpdateAccessoryScreenState extends State<UpdateAccessoryScreen> {
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

  String? selectedFile = null;
  Uint8List? image = null;
  String type = '';
  String branch_id = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Accessory'),
      ),
      
  
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Accessory type'),
                value: widget.accessory!.type,
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
                    return 'Please select a type';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Accessory image'),
                readOnly: true, // Make it read-only
                onTap: _pickImage,
                controller: TextEditingController(
                    text: selectedFile != null
                        ? selectedFile!.split('/').last
                        : null),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Accessory branch_id'),
                initialValue: widget.accessory!.branch_id.toString(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter branch id';
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.accessory!.branch_id = int.parse(value);
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
                    AppAccessoriesService aas = AppAccessoriesService();
                    bool? result = await aas.UpdateAccessory(
                        id: widget.accessory!.id.toString(),
                        type: type,
                        image: image,
                        SelectedFile: selectedFile,
                        branch_id: branch_id);
                    if (result == true) {
                      print('success');
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
