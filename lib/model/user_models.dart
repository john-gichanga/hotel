class UserModel {
  String uid;
  String email;

  UserModel({
    required this.uid,
    required this.email,
  });
//serialize data to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'email': email,
    };
  }

//Deserialize JSON data to object received from cloud firestore
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['id'],
      email: json['email'],
    );
  }
}
