import 'package:clothes_store/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State <LoginScreen> {
  TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    final _formkey =GlobalKey<FormState>();

    @override
    void initState(){
      super.initState();
    }

    @override
    void dispose(){
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement 
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              validator: (value)=>value!.isEmpty?"plese enter valid email":null,
            ),
            TextFormField(
              controller: _passwordController,
              validator: (value)=>value!.isEmpty?"plese enter valid password":null,
            ),
             const SizedBox(height: 10,),
              TextButton ( 
               style: TextButton.styleFrom(  
                minimumSize: Size(double.infinity, 36),  
                backgroundColor: Colors.blue,  
              ),  
              child: Text( 'Login',  
                style: TextStyle(color: Colors.white),  
              ),  
              onPressed: () {  
                Map <String, dynamic> creds = {
                  'email':_emailController.text,
                  'password': _passwordController.text,
                  'device_name':'mobile',
                };
                if(_formkey.currentState!.validate()){
                  Provider.of<Auth>(context,listen: false)
                  .login(creds:creds);
                  Navigator.pop(context);
                } 
              },   
            
          ),
             
             
          ],
        ), 
            ),
      ));
 
  }
}

class FlatButton {
}