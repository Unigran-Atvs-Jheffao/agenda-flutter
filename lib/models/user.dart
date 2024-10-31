class User {
  int? id;
  String name;
  String password;

  User({required this.name, required this.password, this.id});
  
  Map<String,dynamic> toMap(){
    return {
      "name": name,
      "password": password,
    };
  }

  factory User.fromMap(Map<String,dynamic> map){
    return User(
      name: map["name"],
      password: map["password"]
    );
  }
}