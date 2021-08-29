import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccom_mobile/components/custom_date_input/custom_date_input_controller.dart';
import 'package:vaccom_mobile/components/custom_picker_input/custom_picker_input_controller.dart';
import 'package:vaccom_mobile/network/response/mapping/tinhthanh.dart';

import 'package:vaccom_mobile/view_model/base.dart';

class RegisterInjectionController extends GetxController with BaseViewModel {
  var name = 'ok'.obs;
  List<PickerItem> gender = [
    PickerItem(title: 'Nam', value: 0),
    PickerItem(title: 'Nữ', value: 1),
    PickerItem(title: 'Không xác định', value: 2),
  ];

  TextEditingController nameCtrl = TextEditingController();
  PickerController genderCtrl = PickerController();
  DatePickerController dobCtrl = DatePickerController();
  TextEditingController idCtrl = TextEditingController();
  TextEditingController bhytCtrl = TextEditingController();
  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  PickerController cityCtrl = PickerController();
  PickerController districtCtrl = PickerController();
  PickerController wardCtrl = PickerController();
  TextEditingController addressCtrl = TextEditingController();
  PickerController groupCtrl = PickerController();
  TextEditingController unitCtrl = TextEditingController();
  PickerController csytCtrl = PickerController();
  PickerController localCtrl = PickerController();
  PickerController danTocCtrl = PickerController();
  PickerController quocTichCtrl = PickerController();
  TextEditingController tieuSuCtrl = TextEditingController();
  TextEditingController benhLyCtrl = TextEditingController();
  TextEditingController thuocCtrl = TextEditingController();
  DatePickerController ngayDKCtrl = DatePickerController();
  TextEditingController luuYCtrl = TextEditingController();

  @override
  onInit() {
    super.onInit();
    genderCtrl.listData = gender;
    // Future.wait([
    getThanhPho();
    // ]);
  }

  Future getThanhPho() async {
    try {
      List<TinhThanh> data = await api.getCity();
      cityCtrl.listData = TinhThanh.parsePicker(data);
    } catch (e) {
      debugPrint(e);
      throw e;
    }
  }
}
