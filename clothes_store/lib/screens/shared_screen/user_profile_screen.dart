// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:clothes_store/services/auth.dart';

// import '../../services/auth_remastered.dart'; // Import your Auth class

// class UserProfile extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<Auth>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Profile'),
//         backgroundColor: Colors.blueAccent,
//         shadowColor: Colors.black,
//         elevation: 2,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             CircleAvatar(
//               backgroundImage: NetworkImage(auth.user.name),
//               radius: 50,
//             ),
//             SizedBox(height: 40),
//             Text(
//               'Name: ${auth.user.name}',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 40),
//             Text(
//               'Email: ${auth.user.email}',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 40),
//             Text(
//               'Role: ${auth.user.role}',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 40),
//             Text(
//               'id: ${auth.user.id}',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:clothes_store/screens/shared_screen/edit_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clothes_store/services/auth.dart';
// import 'NewPage.dart'; // Import the new page
import '../../services/auth_remastered.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
 String image = auth.user.image;
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('User Profile'),
        // backgroundColor: const Color.fromARGB(255, 255, 68, 115),
        backgroundColor: Colors.blueAccent,
        shadowColor: Colors.black,
        elevation: 2,
      ),
      body: Container(
        decoration:  BoxDecoration(
      //    color: Color.fromARGB(255, 191, 194, 195),
          image: DecorationImage(
            image: AssetImage('assets/images/clothes-background.jpg'), // Add your background image here
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               CircleAvatar(
                              backgroundImage: AssetImage(image),
                             
                              //NetworkImage(auth.user.image??''),
                              //  backgroundColor: Colors.blue,
                              radius: 100,
                             // child: Image.network(userImage),
                            ),
              const SizedBox(height: 20, width:50),
              Text(
                'Name: ${auth.user.name}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20, width:50),
              Text(
                'Email: ${auth.user.email}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20, width:50),
              Text(
                'Role: ${auth.user.role}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20, width:50),
              Text(
                'id: ${auth.user.id}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20, width:50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewPage()),
                  );
                },
                child: const Text('edit password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
