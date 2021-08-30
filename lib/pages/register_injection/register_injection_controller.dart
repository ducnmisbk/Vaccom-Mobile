import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccom_mobile/components/custom_date_input/custom_date_input_controller.dart';
import 'package:vaccom_mobile/components/custom_picker_input/custom_picker_input_controller.dart';
import 'package:vaccom_mobile/model/base_item.dart';
import 'package:vaccom_mobile/network/response/response.dart';

import 'package:vaccom_mobile/view_model/base.dart';

class RegisterInjectionController extends GetxController with BaseViewModel {
  var name = ''.obs;
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
    Future.wait([
      getThanhPho(),
      getDoiTuong(),
      getCSYT(),
      getDanToc(),
      getQuocTich(),
    ]);
  }

  Future getThanhPho() async {
    try {
      List<TinhThanh> data = await api.getCity();
      if (data != null) {
        cityCtrl.listData = BaseItem.parsePicker(data);
      }
    } catch (e) {
      debugPrint(e);
      throw e;
    }
  }

  Future getDoiTuong() async {
    return api
        .getDoiTuong()
        .then((d) => groupCtrl.listData = BaseItem.parsePicker(d));
  }

  Future getCSYT() async {
    return api
        .getCSYT()
        .then((d) => csytCtrl.listData = CoSoYTe.parsePicker(d));
  }

  Future getDanToc() async {
    return api
        .getDanToc()
        .then((d) => danTocCtrl.listData = BaseItem.parsePicker(d));
  }

  Future getQuocTich() async {
    return api
        .getQuocGia()
        .then((d) => quocTichCtrl.listData = BaseItem.parsePicker(d));
  }

  Future getQuanHuyen(int id) {
    return api
        .getDistrict(cityId: id)
        .then((d) => districtCtrl.listData = BaseItem.parsePicker(d));
  }

  Future getPhuongXa(int id) {
    return api
        .getPhuongXa(districtId: id)
        .then((d) => wardCtrl.listData = BaseItem.parsePicker(d));
  }

  Future getDiaBanCoSo(int id) {
    return api
        .getDiaBanCoSo(id)
        .then((d) => localCtrl.listData = BaseItem.parsePicker(d));
  }
}
