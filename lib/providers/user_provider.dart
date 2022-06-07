import 'package:flutter/material.dart';
import 'package:twitch_clone/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(uid: '', username: '', email: '');
  //getter
  User get user => _user;

  //setter
  setUser(User user){
    _user = user;
    notifyListeners();
  }
}
