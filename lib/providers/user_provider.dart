import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:testproject/models/user.dart';
import 'package:testproject/resources/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  final AuthMethods _authMethods = AuthMethods();

  UserModel getUser() => _user!;

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
