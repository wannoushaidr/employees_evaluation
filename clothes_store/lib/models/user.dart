  class UserModel{
    String name;
    String email;
    // String avatar;
    int id;
    String role; // Add the role field
    String? password;
    String? image;


    UserModel({required this.name, required this.email , required this.role, required  this.id, this.password,required this.image});

    UserModel.fromJson(Map<String,dynamic> json):
    name = json['name'],
    email = json['email'],
    // avatar = json['avatar'],
    id = json['id'],
    role = json['role'],// Initialize the role field
    password = json['password']??'',
    image = json['image']??''; // Initialize the role field



    @override  
    String toString() {  
      return 'User{ name: $name, email: $email,role: $role,id: $id,password: $password}';  
    }  


  }
