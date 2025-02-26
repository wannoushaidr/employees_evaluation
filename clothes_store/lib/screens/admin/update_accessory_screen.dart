import 'dart:typed_data';

import 'package:clothes_store/models/accessory_model.dart';
import 'package:clothes_store/models/branch_model.dart';
import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/screens/admin/show_all_companies_screen.dart';
import 'package:clothes_store/services/accessory_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../services/branch_services.dart';
import '../../services/company_services.dart';

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
          image = result.files.single.bytes!;
          selectedFile = result.files.single.name;
        });
      }
    } catch (e) {
      print('Error picking file: $e');
      // Handle error, e.g., show a dialog or message
    }
  }

  String? selectedFile;
  Uint8List? image;
  String type = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Accessory'),
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
                  children: [
                    SizedBox(
                      width: 500,
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Accessory Category',
                          border: OutlineInputBorder(),
                        ),
                        value: widget.accessory!.type,
                        items: <String>['dressing_room', 'exit_door']
                            .map((String value) {
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
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Accessory image',
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true, // Make it read-only
                        onTap: _pickImage,
                        validator: (value) {
                          if (image == null) {
                            return 'Please upload an image';
                          }
                          return null;
                        },
                        controller: TextEditingController(
                            text: selectedFile?.split('/').last),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Accessory branch_id',
                          border: OutlineInputBorder(),
                        ),
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
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(500, 50),
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Process the data (e.g., send it to a server or save it locally)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          AppAccessoriesService aas = AppAccessoriesService();
                          bool? result = await aas.UpdateAccessory(
                              id: widget.accessory!.id.toString(),
                              type: type,
                              image: image!,
                              SelectedFile: selectedFile,
                              branch_id:
                                  widget.accessory!.branch_id.toString());
                          if (result == true) {
                            print('success');
                            Navigator.pop(context);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Accessory been updated successfully')),
                            );
                          } else {
                            print('error');
                          }
                        }
                      },
                      child: const Text(
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
