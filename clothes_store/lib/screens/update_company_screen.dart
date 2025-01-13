import 'package:clothes_store/models/company_model.dart';
import 'package:clothes_store/screens/show_all_companies_screen.dart';
import 'package:flutter/material.dart';

import '../services/company_services.dart';

class UpdateCompanyScreen extends StatefulWidget {
  UpdateCompanyScreen({super.key, required this.company});
  CompanyModel? company;

  @override
  State<UpdateCompanyScreen> createState() => _UpdateCompanyScreenState();
}

class _UpdateCompanyScreenState extends State<UpdateCompanyScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Company'),
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
                decoration: InputDecoration(labelText: 'Company Name'),
                initialValue: widget.company!.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter company name';
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.company!.name = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Number'),
                initialValue: widget.company!.number.toString(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter contact number';
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.company!.number = int.parse(value);
                },
              ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Number of Branches'),
              //   initialValue: widget.company!.number_of_branch.toString(),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter number of branches';
              //     }
              //     return null;
              //   },
              //   onChanged: (value) {
              //     widget.company!.number_of_branch = int.parse(value);
              //   },
              // ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                initialValue: widget.company!.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.company!.email = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                initialValue: widget.company!.address,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Address';
                  }
                  return null;
                },
                onChanged: (value) {
                  widget.company!.address = value;
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
                    AppCompaniesService aps = AppCompaniesService();
                    bool? result = await aps.UpdateCompany(
                        id: widget.company!.id.toString(),
                        name: widget.company!.name,
                        number: widget.company!.number.toString(),
                        // number_of_branches:
                            // widget.company!.number_of_branch.toString(),
                        email: widget.company!.email,
                        address: widget.company!.address);
                    if (result == true) {
                      print('success');
                      Navigator.pop(context);
                      Navigator.pop(context);
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
