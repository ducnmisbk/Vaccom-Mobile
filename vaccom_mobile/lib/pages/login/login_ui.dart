import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccom_mobile/commons/color.dart';
import 'package:vaccom_mobile/commons/toast.dart';
import 'package:vaccom_mobile/commons/utils.dart';
import 'package:vaccom_mobile/components/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:vaccom_mobile/components/password_input.dart';
import 'package:vaccom_mobile/network/global.dart';
import 'package:vaccom_mobile/pages/login/login_vm.dart';
import 'package:vaccom_mobile/router/router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final viewModel = LoginViewModel();

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  void onLogin() {
    Utils.hideKeyboard();

    if (!viewModel.isValid) {
      Toast.show(text: r'Vui lòng nhập đủ thông tin đăng nhập');
      return;
    }

    Toast.showLoading();

    viewModel.login().then((value) {
      Utils.saveToken(value);
      getUser(value.userId);
    }).catchError((e) => Toast.show(text: e.toString()));
  }

  void getUser(int id) {
    viewModel.getUser(id).then((value) {
      Toast.dismiss();
      Global.shared.saveUser(value);
      Get.offAndToNamed(GetRouter.main);
    }).catchError((e) => Toast.show(text: e.toString()));
  }

  @override
  Widget build(BuildContext context) {
    double padding = (MediaQuery.of(context).size.width - 300) / 2;

    var loginButton = Container(
      padding: EdgeInsets.only(top: 16),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
        disabledColor: Colors.blueGrey,
        hoverColor: Colors.lightBlue,
        color: AppColor.main,
        onPressed: onLogin,
        child: Text(
          'login'.tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.merriweather(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: InkWell(
          onTap: () => Utils.hideKeyboard(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            height: Get.height,
            decoration: BoxDecoration(),
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: padding,
                          right: padding,
                          bottom: 30,
                        ),
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              colors: [Color(0xFF171cc2), Color(0xFFff5200)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 36,
                              ),
                              child:
                                  Image.asset('assets/images/logo_banner.png'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            left: padding,
                            right: padding,
                          ),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFFFEFEFE),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.white54.withOpacity(0.2),
                              width: 0.7,
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Color(0xFF3A5160).withOpacity(0.3),
                                  blurRadius: 2.0),
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              CustomTextField(
                                controller: viewModel.usernameCtrl,
                                label: 'username'.tr,
                                type: CustomTextFieldType.username,
                                onSubmitted: (_) => FocusScope.of(context)
                                    .requestFocus(_focusNode),
                              ),
                              SizedBox(height: 16),
                              PasswordInput(
                                focusNode: _focusNode,
                                controller: viewModel.passwordCtrl,
                                label: 'password'.tr,
                                onSubmitted: (_) => onLogin(),
                              ),
                              SizedBox(height: 7.0),
                              loginButton,
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            padding: EdgeInsets.only(
                              bottom:
                                  16 + MediaQuery.of(context).padding.bottom,
                            ),
                            child: Text(
                              'HỆ THỐNG QUẢN LÝ &\nTỔ CHỨC ĐIỂM TIÊM CHỦNG',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.merriweather(
                                color: AppColor.main,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
