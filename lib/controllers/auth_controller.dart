import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:twitch_clone/providers/user_provider.dart';
import 'package:twitch_clone/utils/constants.dart';
import 'package:twitch_clone/models/user.dart' as model;
import 'package:twitch_clone/utils/utils.dart';

// class AuthController {
//   final _userRef = firestore.collection('users');

//   Future<DocumentSnapshot?> getCurrentUser(String? uid) async {
//     if (uid != null) {
//       return await _userRef.doc(uid).get();
//     }
//     return null;
//   }

//   void Logout() async{
//     await firebaseAuth.signOut();
//   }

//   Future<bool> signUpUser(BuildContext context, String email, String password,
//       String username) async {
//     try {
//       UserCredential authResults = await firebaseAuth
//           .createUserWithEmailAndPassword(email: email, password: password);
//       final user = authResults.user;
//       if (user != null) {
//         // await _userRef.doc(user.uid).set({
//         //   'username': username,
//         //   'email': email,
//         //   'uid': user.uid,
//         // });
//         // return true;

//         model.User _user =
//             model.User(uid: user.uid, username: username, email: email);
//         await _userRef.doc(user.uid).set(_user.toJson());
//         Provider.of<UserProvider>(context, listen: false).setUser(_user);
//         return true;
//       }
//     } on FirebaseAuthException catch (e) {
//       print(e.message!);
//       showSnackBar(context, e.message!);
//     }
//     return false;
//   }

//   Future<bool> LoginUser(
//     BuildContext context, String email, String password) async {
//   try {
//     UserCredential authResults = await firebaseAuth.signInWithEmailAndPassword(
//         email: email, password: password);
//     final user = authResults.user;
//     if (user != null) {
//       Provider.of<UserProvider>(context, listen: false)
//           .setUser(model.User.fromJson(await getCurrentUser(user.uid) as DocumentSnapshot));
//       return true;
//     }
//   } on FirebaseAuthException catch (e) {
//     print(e.message!);
//     showSnackBar(context, e.message!);
//   }
//   return false;
// }

// }

class AuthMethods {
  final _userRef = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;
  void logout() async {
    _auth.signOut();
  }

  Future<Map<String, dynamic>?> getCurrentUser(String? uid) async {
    if (uid != null) {
      final snap = await _userRef.doc(uid).get();
      return snap.data();
    }
    return null;
  }

  Future<bool> signUpUser(
    BuildContext context,
    String email,
    String username,
    String password,
  ) async {
    bool res = false;
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (cred.user != null) {
        model.User user = model.User(
          username: username.trim(),
          email: email.trim(),
          uid: cred.user!.uid,
        );
        await _userRef.doc(cred.user!.uid).set(user.toMap());
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }

  Future<bool> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    bool res = false;
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (cred.user != null) {
        Provider.of<UserProvider>(context, listen: false).setUser(
          model.User.fromMap(
            await getCurrentUser(cred.user!.uid) ?? {},
          ),
        );
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
    return res;
  }
}
