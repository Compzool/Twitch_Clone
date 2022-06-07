// import 'package:cloud_firestore/cloud_firestore.dart';

// class User {
//   final String uid;
//   final String username;
//   final String email;

//   User({required this.uid, required this.username, required this.email});

//   Map<String, dynamic> toJson() {
//     return{
//     'uid': uid,
//     'username': username,
//     'email': email,
//     };
//   }
//   static User fromJson(DocumentSnapshot snapshot) {
//     final snap = snapshot.data() as Map<String,dynamic>;
//     return User(
//       uid: snap['uid'],
//       username: snap['username'],
//       email: snap['email'],
//     );
//   }
// }

import 'dart:convert';

class User {
  final String uid;
  final String username;
  final String email;

  User({
    required this.uid,
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
