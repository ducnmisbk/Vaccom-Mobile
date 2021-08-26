import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccom_mobile/router/router.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    await Future.delayed(Duration(milliseconds: 500));

    Get.offNamed(GetRouter.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(),
    );
  }
}