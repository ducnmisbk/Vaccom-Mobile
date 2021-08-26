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
  int _selectedIndex = 0;
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
    var scaffoldKey = GlobalKey<ScaffoldState>();

    List<DrawerItemData> drawerData = [
      DrawerItemData(title: 'Checkin y tế tại điểm tiêm chủng'),
      DrawerItemData(title: 'Xem thông tin lịch sử tiêm chủng'),
      DrawerItemData(title: 'Xác nhận lịch hẹn tiêm'),
      DrawerItemData(title: 'Cập nhật diễn biến sau tiêm'),
      DrawerItemData(title: 'Nhập đăng kí đối tượng tiêm mới'),
      DrawerItemData(title: 'Duyệt danh sách đối tượng tiêm mới'),
      DrawerItemData(title: 'Tra cứu danh sách đối tượng chính thức'),
      DrawerItemData(title: 'Xác nhận danh sách gọi tiêm'),
      DrawerItemData(title: 'Quản lý danh sách checkin'),
      DrawerItemData(title: 'Nhập kết quả sau tiêm'),
    ];

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              children: List.generate(drawerData.length, (int index) {
                return ListTile(
                  title: Text(drawerData[index].title),
                  onTap: drawerData[index].onTap,
                );
              })),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
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
                              fontSize: 15),
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
                            // final user = Global.shared.currentUser;
                            // Toast.show(text: user.hoVaTen);
                            scaffoldKey.currentState.openDrawer();
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
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Checkin y tế',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Lịch sử tiêm chủng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code),
              label: 'QR của bạn',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more),
              label: 'Thêm',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class DrawerItemData {
  String title = '';
  Function onTap = () => {};
  DrawerItemData({this.title, this.onTap});
}
