import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaccom_mobile/commons/color.dart';
import 'package:vaccom_mobile/components/dash_divider.dart';
import 'package:vaccom_mobile/network/response/response.dart';

enum IAction { edit, delete, approved }

typedef InjectorAction = Function(IAction, NguoiTiemChung);

class InjectorCell extends StatelessWidget {
  final Function(NguoiTiemChung) onTap;
  final NguoiTiemChung item;
  final AnimationController animationController;
  final Animation animation;
  final InjectorAction action;

  const InjectorCell({
    Key key,
    this.item,
    this.animationController,
    this.animation,
    this.action,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subStyle = GoogleFonts.roboto(
      color: Color(0xff797878),
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );

    var textStyle = GoogleFonts.roboto(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: AppColor.nearlyBlack,
    );

    final body = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColor.grey.withOpacity(0.3),
            blurRadius: 1,
          ),
        ],
      ),
      padding: EdgeInsets.all(8),
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: r"Họ tên: ",
                  style: subStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text: '${item.hoVaTen}',
                      style: textStyle.copyWith(
                        color: AppColor.link,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              DashDivider(),
              RichText(
                text: TextSpan(
                  text: r"Ngày sinh: ",
                  style: subStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text: '${item.ngaySinh}',
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              DashDivider(),
              RichText(
                text: TextSpan(
                  text: r"CMND/CCCD: ",
                  style: subStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text: '${item.cmtcccd}',
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              DashDivider(),
              RichText(
                text: TextSpan(
                  text: r"Số điện thoại: ",
                  style: subStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text: '${item.soDienThoai}',
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              DashDivider(),
              RichText(
                text: TextSpan(
                  text: r"Địa chỉ: ",
                  style: subStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text: '${item.diaChiNoiO} ',
                      style: textStyle,
                    ),
                    TextSpan(
                      text: '- ${item.phuongXaTen} ',
                      style: textStyle,
                    ),
                    TextSpan(
                      text: '- ${item.quanHuyenTen} ',
                      style: textStyle,
                    ),
                    TextSpan(
                      text: '- ${item.tinhThanhTen}.',
                      style: textStyle,
                    ),
                  ],
                ),
              ),
              DashDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () => action(IAction.edit, item),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, 6, 8, 4),
                      child: Icon(Icons.edit, color: Colors.green, size: 18),
                    ),
                  ),
                  InkWell(
                    onTap: () => action(IAction.delete, item),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, 6, 8, 4),
                      child: Icon(Icons.delete_forever, color: Colors.redAccent, size: 18),
                    ),
                  ),
                  InkWell(
                    onTap: () => action(IAction.approved, item),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(8, 6, 8, 4),
                      child: Icon(Icons.addchart, color: Colors.blueAccent, size: 18),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
              0.0,
              50 * (1.0 - animation.value),
              0.0,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 1),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  onTap(item);
                },
                child: body,
              ),
            ),
          ),
        );
      },
    );
  }
}
