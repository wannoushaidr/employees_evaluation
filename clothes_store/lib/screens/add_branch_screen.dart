import 'package:clothes_store/helper/snackbar.dart';
import 'package:clothes_store/services/branch_services.dart';
import 'package:flutter/material.dart';

import '../services/company_services.dart';

class AddBranchScreen extends StatefulWidget {
  const AddBranchScreen({super.key, required this.company_id});
  final String company_id;
  @override
  _AddBranchScreenState createState() => _AddBranchScreenState();
}

class _AddBranchScreenState extends State<AddBranchScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phone = '';
  String address = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Branch'),
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
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Branch Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter company name';
                  }
                  return null;
                },
                onChanged: (value) {
                  name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
                onChanged: (value) {
                  phone = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
                onChanged: (value) {
                  address = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onChanged: (value) {
                  email = value;
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
                    AppBranchesService abs = AppBranchesService();
                    bool? result = await abs.AddNewBranch(
                        name: name,
                        phone: phone,
                        address: address,
                        email: email,
                        company_id: widget.company_id);
                    if (result == true) {
                      print('success');
                      Navigator.pop(context);
                       SnackbarShow.showSnackbar(context, "added sussesfully ");
                    } else {
                      SnackbarShow.showSnackbar(context, " error");
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
