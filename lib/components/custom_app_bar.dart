import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccom_mobile/commons/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final bool canBack;
  const CustomAppBar({
    Key key,
    this.title = '',
    this.actions = const [],
    this.canBack = true,
  }) : super(key: key);

  @override
  Size get preferredSize {
    return new Size.fromHeight(AppBar().preferredSize.height);
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF171cc2), Color(0xFFff5200)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          AppBar(
            brightness: Brightness.dark,
            backgroundColor: Colors.transparent,
            leading: canBack
                ? IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                      Get.back();
                    })
                : null,
            title: Text(
              title,
              style: GoogleFonts.roboto(
                color: AppColor.nearlyWhite,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            actions: actions,
          )
        ],
      ),
    );
  }
}
