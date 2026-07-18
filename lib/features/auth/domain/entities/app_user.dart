class AppUser {
  final String uid;
  final String email;
  const AppUser({required this.email, required this.uid});

  //for conrvert app user to json
  Map<String, dynamic> toJson() {
    return {'uid': uid, 'email': email};
  }

  //for conver json to user
  factory AppUser.fromJson(Map<String,dynamic> json) {
    return AppUser(email: json['email'], uid: json['json']);
  }
}
