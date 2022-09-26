class UserModel {

  final String email;
  final String? userid;

  UserModel({
    required this.email,
    this.userid
  });

  Map<String, dynamic> toMap() {
    return {
      'email' : email,
      'userid' : userid
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
        email: map['email'] ?? '',
      userid: map['userid'] ?? ''
    );
  }
}