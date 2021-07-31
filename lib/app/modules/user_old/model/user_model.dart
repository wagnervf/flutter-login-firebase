import 'dart:convert';

class UserModel {
  final String uid;
  final String displayName;
  final String email;
  final bool emailVerified;
  final String photoURL;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.emailVerified,
    required this.photoURL,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'emailVerified': emailVerified,
      'photoURL': photoURL,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      displayName: map['displayName'],
      email: map['email'],
      emailVerified: map['emailVerified'],
      photoURL: map['photoURL'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
