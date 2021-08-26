
import 'package:flutter/material.dart';
import 'package:vaccom_mobile/commons/utils.dart';
import 'package:vaccom_mobile/view_model/base.dart';

class LoginViewModel extends BaseViewModel {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  ///
  String get username => usernameCtrl.text;
  String get password => passwordCtrl.text;

  bool get isValid => username.isNotEmpty && password.isNotEmpty;

  LoginViewModel() {
    usernameCtrl.text = r'anhtt';
    passwordCtrl.text = r'fds@22021';
  }

  Future<bool> login() async {
    var params = {
      'username': username,
      'password': password
    };
    logger.info(params);

    await Future.delayed(Duration(milliseconds: 1000));

    return true;
  }
}
