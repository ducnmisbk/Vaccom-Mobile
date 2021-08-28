import 'package:flutter/material.dart';
import 'package:vaccom_mobile/commons/styles.dart';
import 'package:vaccom_mobile/commons/utils.dart';

class BaseScaffoldWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget leading;
  final List<Widget> actions;

  const BaseScaffoldWidget({
    this.title,
    this.leading,
    this.actions,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.gradientAppBar(
        child: AppBar(
          backgroundColor: Colors.transparent,
          brightness: Brightness.dark,
          title: Text(
            '${title ?? ''}',
            style: AppStyle.appBarTitle,
          ),
          leading: leading,
          actions: actions,
        ),
      ),
      body: Stack(
        children: <Widget>[
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () => Utils.hideKeyboard(),
            child: child,
          ),
        ],
      ),
    );
  }
}
