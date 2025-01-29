// import 'package:clothes_store/models/user.dart';
// import 'package:clothes_store/services/auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// class LoginScreen extends StatefulWidget{
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State <LoginScreen> {
//   TextEditingController _emailController = TextEditingController();
//     TextEditingController _passwordController = TextEditingController();
//     final _formkey =GlobalKey<FormState>();




//     @override
//     void initState(){
//       super.initState();
//     }

//     @override
//     void dispose(){
//       _emailController.dispose();
//       _passwordController.dispose();
//       super.dispose();
//     }

//     Future<void> _login() async {  
//     Map<String, dynamic> creds = {  
//       'email': _emailController.text,  
//       'password': _passwordController.text,  
//       'device_name': 'mobile',  
//     };  

//     if (_formkey.currentState!.validate()) {  
//       Provider.of<Auth>(context, listen: false).login(creds: creds, context: context);  

//       // Check if the user is authenticated  
//       if (Provider.of<Auth>(context, listen: false).authenticated) {  
//         // Navigate based on user role  
//         String role = Provider.of<Auth>(context, listen: false).user.role;  

//         if (role == 'admin') {  
//           Navigator.pushReplacementNamed(context, "admin_main_Screen");  
//         } else if (role == 'manager') {  
//           Navigator.pushReplacementNamed(context, "manager_mainScreen");  
//         }else if (role == 'supervisior') {  
//           Navigator.pushReplacementNamed(context, "supervisor_mainScreen");
//          }else {  
//           Navigator.pushReplacementNamed(context, "manager_mainScreen"); // Default or user screen  
//         }  
//       }  
//     }  
//   } 
  
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement 
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: _formkey,
//         child:Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextFormField(
//               controller: _emailController,
//               validator: (value)=>value!.isEmpty?"plese enter valid email":null,
//               decoration: InputDecoration( labelText: 'Email', hintText: 'Enter your email', border: OutlineInputBorder(),
//               )
//             ),
//             TextFormField(
//               controller: _passwordController,
//               validator: (value)=>value!.isEmpty?"plese enter valid password":null,
//               decoration: InputDecoration( labelText: 'Password', hintText: 'Enter your password', border: OutlineInputBorder(),
//               )
//             ),
//              const SizedBox(height: 10,),
//               TextButton ( 
//                style: TextButton.styleFrom(  
//                 minimumSize: Size(double.infinity, 36),  
//                 backgroundColor: Colors.blue,  
//               ),  
//               child: Text( 'Login',  
//                 style: TextStyle(color: Colors.white),  
//               ),  
//               onPressed: () {  _login();

//                 // Map <String, dynamic> creds = {
//                 //   'email':_emailController.text,
//                 //   'password': _passwordController.text,
//                 //   'device_name':'mobile',
//                 // };
//                 // if(_formkey.currentState!.validate()){
//                 //   Provider.of<Auth>(context,listen: false)
//                 //   .login(creds:creds, context: context);
//                 //   Navigator.pop(context);
//                 // } 
//               },   
            
//           ),
             
             
//           ],
//         ), 
//             ),
//       ));
 
//   }
// }

// class FlatButton {
// }



// **************************************************************************************************

// **************************************************************************************************
// **************************************************************************************************
// **************************************************************************************************
// **************************************************************************************************
// **************************************************************************************************
// **************************************************************************************************
// **************************************************************************************************
// **************************************************************************************************
// **************************************************************************************************
// **************************************************************************************************





import 'package:clothes_store/models/user.dart';
import 'package:clothes_store/services/auth.dart';
import 'package:clothes_store/services/auth_remastered.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    Map<String, dynamic> creds = {
      'email': _emailController.text,
      'password': _passwordController.text,
      'device_name': 'mobile',
    };
    

    if (_formkey.currentState!.validate()) {
      try{
      Auth auth = Auth();
      String? token = await auth.login(creds: creds, context: context);
      Map<String,dynamic>? data = await auth.tryToken(token: token!);

      UserModel user = UserModel.fromJson(data!);
       Provider.of<Auth>(context, listen: false).user.id = user.id;
        Provider.of<Auth>(context, listen: false).user.name = user.name;
         Provider.of<Auth>(context, listen: false).user.email = user.email;
          Provider.of<Auth>(context, listen: false).user.role = user.role;
          Provider.of<Auth>(context, listen: false).authenticated = true;
           
      print(user);
      }catch(e)
      {print(e);}
print(Provider.of<Auth>(context, listen: false).authenticated);
      if (Provider.of<Auth>(context, listen: false).authenticated) {
        // Navigate based on user role
        String role = Provider.of<Auth>(context, listen: false).user.role;

        if (role == 'admin') {
          Navigator.pushReplacementNamed(context, "admin_main_Screen");
        } else if (role == 'manager') {
          Navigator.pushReplacementNamed(context, "manager_mainScreen");
        } else if (role == 'supervisor') {
          Navigator.pushReplacementNamed(context, "supervisor_mainScreen");
        }
        else if (role == 'customer_service') {
          Navigator.pushReplacementNamed(context, "customerService_mainScreen");
        } else {
          Navigator.pushReplacementNamed(context, "default_mainScreen"); // Default or user screen
        }
      }
    }
    }
  
  
  //   if (_formkey.currentState!.validate()) {
  //     Provider.of<AuthRemastered>(context, listen: false).login(creds: creds, context: context);

  //     // Check if the user is authenticated
  //     if (Provider.of<AuthRemastered>(context, listen: false).authenticated) {
  //       // Navigate based on user role
  //       String role = Provider.of<Auth>(context, listen: false).user.role;

  //       if (role == 'admin') {
  //         Navigator.pushReplacementNamed(context, "admin_main_Screen");
  //       } else if (role == 'manager') {
  //         Navigator.pushReplacementNamed(context, "manager_mainScreen");
  //       } else if (role == 'supervisor') {
  //         Navigator.pushReplacementNamed(context, "supervisor_mainScreen");
  //       }
  //       else if (role == 'customer_service') {
  //         Navigator.pushReplacementNamed(context, "customerService_mainScreen");
  //       } else {
  //         Navigator.pushReplacementNamed(context, "default_mainScreen"); // Default or user screen
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                validator: (value) => value!.isEmpty ? "Please enter a valid email" : null,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                validator: (value) => value!.isEmpty ? "Please enter a valid password" : null,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(double.infinity, 36),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
