import 'package:flutter/material.dart';

class AddCompanyScreen extends StatefulWidget {  
  @override  
  _AddCompanyScreenState createState() => _AddCompanyScreenState();  
}  

class _AddCompanyScreenState extends State<AddCompanyScreen> {  
  final _formKey = GlobalKey<FormState>();  
  final TextEditingController _stringField1Controller = TextEditingController();  
  final TextEditingController _stringField2Controller = TextEditingController();  
  final TextEditingController _stringField3Controller = TextEditingController();  
  final TextEditingController _integerFieldController = TextEditingController();  
  final TextEditingController _stringField4Controller = TextEditingController();  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: Text('Simple Form Example'),  
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
            children: <Widget>[  
              TextFormField(  
                controller: _stringField1Controller,  
                decoration: InputDecoration(labelText: 'String Field 1'),  
                validator: (value) {  
                  if (value == null || value.isEmpty) {  
                    return 'Please enter some text';  
                  }  
                  return null;  
                },  
              ),  
              TextFormField(  
                controller: _stringField2Controller,  
                decoration: InputDecoration(labelText: 'String Field 2'),  
                validator: (value) {  
                  if (value == null || value.isEmpty) {  
                    return 'Please enter some text';  
                  }  
                  return null;  
                },  
              ),  
              TextFormField(  
                controller: _stringField3Controller,  
                decoration: InputDecoration(labelText: 'String Field 3'),  
                validator: (value) {  
                  if (value == null || value.isEmpty) {  
                    return 'Please enter some text';  
                  }  
                  return null;  
                },  
              ),  
              TextFormField(  
                controller: _integerFieldController,  
                decoration: InputDecoration(labelText: 'Integer Field'),  
                keyboardType: TextInputType.number,  
                validator: (value) {  
                  if (value == null || value.isEmpty) {  
                    return 'Please enter an integer';  
                  }  
                  if (int.tryParse(value) == null) {  
                    return 'Please enter a valid integer';  
                  }  
                  return null;  
                },  
              ),  
              TextFormField(  
                controller: _stringField4Controller,  
                decoration: InputDecoration(labelText: 'String Field 4'),  
                validator: (value) {  
                  if (value == null || value.isEmpty) {  
                    return 'Please enter some text';  
                  }  
                  return null;  
                },  
              ),  
              SizedBox(height: 20),  
              ElevatedButton(  
                onPressed: () {  
                  if (_formKey.currentState!.validate()) {  
                    // Process the data (for demonstration, print to console)  
                    print('String 1: ${_stringField1Controller.text}');  
                    print('String 2: ${_stringField2Controller.text}');  
                    print('String 3: ${_stringField3Controller.text}');  
                    print('Integer: ${_integerFieldController.text}');  
                    print('String 4: ${_stringField4Controller.text}');  
                    // Optionally, clear the fields  
                    _stringField1Controller.clear();  
                    _stringField2Controller.clear();  
                    _stringField3Controller.clear();  
                    _integerFieldController.clear();  
                    _stringField4Controller.clear();
                    
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