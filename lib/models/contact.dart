class Contact {
  int ?id;
  String name;
  String phoneNumber;
  String email;

  Contact({required this.name, required this.email, required this.phoneNumber, this.id});

  Map<String,dynamic> toMap(){
    return {
      "name": name,
      "email": email,
      "phone_number": phoneNumber
    };
  }

  factory Contact.fromMap(Map<String,dynamic> map){
    return Contact(
      name: map["name"],
      email: map["email"],
      phoneNumber: map["phone_number"],
      id: map["id"]);
  }
}