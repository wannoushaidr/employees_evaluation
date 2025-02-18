import 'package:flutter/material.dart';
import 'package:clothes_store/services/user_services.dart'; // Import the service
import 'package:clothes_store/services/user_services.dart'; // Import the service

// class NewPage extends StatefulWidget {
//   @override
//   _NewPageState createState() => _NewPageState();
// }

// class _NewPageState extends State<NewPage> {
//   String email = '';
//   String old_password = '';
//   String new_password = '';
//   String new_password_confirmation = '';

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update Password'),
//       ),
//       // body: Padding(
//       //   padding: const EdgeInsets.all(16.0),
//       body: Container(
//         color: Colors.white,
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Email'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   setState(() {
//                     email = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Old Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your old password';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   setState(() {
//                     old_password = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'New Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your new password';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   setState(() {
//                     new_password = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Confirm New Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please confirm your new password';
//                   }
//                   if (value != new_password) {
//                     return 'Passwords do not match';
//                   }
//                   return null;
//                 },
//                 onChanged: (value) {
//                   setState(() {
//                     new_password_confirmation = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 40),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 8.0),
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(500, 50),
//                     backgroundColor: Colors.blueAccent,
//                   ),
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       showAlert(context, 'Processing Data');
//                       AppUsersService authService = AppUsersService();
//                       print("sssssssssssssss4");
//                       bool? result = await authService.updatePassword(
//                         email: email,
//                         oldPassword: old_password,
//                         newPassword: new_password,
//                         newPasswordConfirmation: new_password_confirmation,
//                       );
//                       print("sssssssssssssss5");
//                       if (result == true) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Password updated successfully')),
//                         );
//                         print('Password updated successfully');
//                         Navigator.pop(context);
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('Failed to update password')),
//                         );
//                         print('Error updating password');
//                       }
//                     }
//                   },
//                   child: Text(
//                     'Update Password',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     )));
//   }

//   void showAlert(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           content: Text(message),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:clothes_store/services/user_services.dart'; // Import the service

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  String email = '';
  String old_password = '';
  String new_password = '';
  String new_password_confirmation = '';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password'),
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
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Old Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your old password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            old_password = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your new password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            new_password = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 500,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirm New Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your new password';
                          }
                          if (value != new_password) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            new_password_confirmation = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      width: 500,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(500, 50),
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            showAlert(context, 'Processing Data');
                            AppUsersService authService = AppUsersService();
                            bool? result = await authService.updatePassword(
                              email: email,
                              oldPassword: old_password,
                              newPassword: new_password,
                              newPasswordConfirmation: new_password_confirmation,
                            );
                            if (result == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Password updated successfully')),
                              );
                              print('Password updated successfully');
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to update password')),
                              );
                              print('Error updating password');
                            }
                          }
                        },
                        child: Text(
                          'Update Password',
                          style: TextStyle(color: Colors.white),
                        ),
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

  void showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
        );
      },
    );
  }
}
