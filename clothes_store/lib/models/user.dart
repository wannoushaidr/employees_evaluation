  class User{
    String name;
    String email;
    // String avatar;
    int id;
    String role; // Add the role field

    User({required this.name, required this.email , required this.role, required  this.id});

    User.fromJson(Map<String,dynamic> json):
    name = json['name'],
    email = json['email'],
    // avatar = json['avatar'],
    id = json['id'],
    role = json['role']; // Initialize the role field
    


    @override  
    String toString() {  
      return 'User{ name: $name, email: $email,role: $role,id: $id}';  
    }  


  }
