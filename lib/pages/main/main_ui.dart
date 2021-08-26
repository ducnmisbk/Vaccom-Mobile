import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccom_mobile/commons/color.dart';
import 'package:vaccom_mobile/commons/toast.dart';
import 'package:vaccom_mobile/commons/utils.dart';
import 'package:vaccom_mobile/model/menu_item.dart';
import 'package:get/get.dart';
import 'package:vaccom_mobile/network/global.dart';
import 'main_item_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> with TickerProviderStateMixin {
  AnimationController animationController;
  bool isLoading = true;

  List<MenuItem> menuList = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    menuList = buildMenuList();

    super.initState();
  }

  buildMenuList() {
    // TODO: Hiển thị menu item theo tài khoản đăng nhập
    return [
      MenuItem(title: 'Menu 1', icon: Icons.book, index: MenuIndex.menu1),
      MenuItem(title: 'Menu 2', icon: Icons.extension, index: MenuIndex.menu2),
      MenuItem(title: 'Menu 3', icon: Icons.link, index: MenuIndex.menu3),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(36),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Color(0xFF171cc2), Color(0xFFff5200)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          r'Dashboard',
                          style: GoogleFonts.roboto(
                            color: AppColor.nearlyWhite,
                            fontWeight: FontWeight.w500,
                            fontSize: 15
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          onTap: () => Utils.showAwesomeDialog(
                            context,
                            title: 'confirm'.tr,
                            message: 'confirm_logout'.tr,
                            isDestructive: true,
                            dismissOnTouchOutside: true,
                            onPressedOK: () => Utils.logout(),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.person_pin,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          onTap: () {
                            final user = Global.shared.currentUser;
                            Toast.show(text: user.hoVaTen);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: GridView(
          padding: EdgeInsets.all(24),
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: List.generate(
            menuList.length,
            (index) {
              var count = menuList.length;
              var animation = Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                  parent: animationController,
                  curve: Interval((1 / count) * index, 1.0,
                      curve: Curves.fastOutSlowIn),
                ),
              );
              animationController.forward();
              return MainItemView(
                menuItem: menuList[index],
                index: index,
                animation: animation,
                animationController: animationController,
                callBack: () {},
              );
            },
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 24.0,
            crossAxisSpacing: 24.0,
            childAspectRatio: 1,
          ),
        ),
      ),
    );
  }
}
