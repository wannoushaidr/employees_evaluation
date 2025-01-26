import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clothes_store/services/auth.dart'; // Import your Auth class

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);

    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(auth.user.name),
              radius: 50,
            ),
            SizedBox(height: 10),
            Text('Name: ${auth.user.name}'),
            SizedBox(height: 5),
            Text('Email: ${auth.user.email}'),
            SizedBox(height: 5),
            Text('Role: ${auth.user.role}'),
          ],
        ),
      ),
    );
  }
}
