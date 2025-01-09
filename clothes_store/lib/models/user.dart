class User{
  String name;
  String email;
  String avatar;

  User({required this.name, required this.email,required this.avatar});

  User.fromJson(Map<String,dynamic> json):
  name = json['name'],
  email = json['email'],
  avatar = json['avatar'];


  @override  
  String toString() {  
    return 'User{ name: $name, email: $email, avatar: $avatar}';  
  }  


}
