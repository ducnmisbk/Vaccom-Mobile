import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccom_mobile/components/custom_app_bar.dart';
import 'package:vaccom_mobile/components/custom_date_input/custom_date_input_ui.dart';
import 'package:vaccom_mobile/components/custom_form_input.dart';
import 'package:vaccom_mobile/components/custom_picker_input/custom_picker_input_ui.dart';
import 'register_injection_controller.dart';

class RegisterInjection extends StatelessWidget {
  final RegisterInjectionController controller =
      Get.put(RegisterInjectionController());

  Widget rowInput(List<Widget> inputList) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          inputList.length,
          (index) => Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: inputList[index],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Register Injection"),
      body: 
      Obx(
        () => 
        Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              children: [
                Text("${controller.name}"),
                rowInput([
                  CustomFormInput(
                    controller: controller.nameCtrl,
                    labelText: 'Họ và tên',
                  ),
                  CustomPickerInput(
                    controller: controller.genderCtrl,
                    mainContext: context,
                    label: 'Giới tính',
                  ),
                ]),
                rowInput([
                  CustomDateInput(
                    controller: controller.dobCtrl,
                    label: 'Ngày sinh',
                  ),
                  CustomFormInput(
                    controller: controller.idCtrl,
                    labelText: 'Số CMND/CCCD',
                  ),
                ]),
                rowInput([
                  CustomFormInput(
                    controller: controller.bhytCtrl,
                    labelText: 'Số thẻ BHYT',
                  ),
                  CustomFormInput(
                    controller: controller.phoneCtrl,
                    keyboardType: TextInputType.phone,
                    labelText: 'Số điện thoại',
                  ),
                ]),
                rowInput([
                  CustomFormInput(
                    controller: controller.emailCtrl,
                    labelText: 'Email',
                  ),
                  CustomPickerInput(
                    controller: controller.cityCtrl,
                    mainContext: context,
                    label: 'Tỉnh/Thành phố',
                    searchPlaceholder: 'Nhập tên Tình/Thành phố'
                  ),
                ]),
                rowInput([
                  CustomPickerInput(
                    controller: controller.districtCtrl,
                    mainContext: context,
                    label: 'Quận/Huyện',
                  ),
                  CustomPickerInput(
                    controller: controller.wardCtrl,
                    mainContext: context,
                    label: 'Phưởng/Xã',
                  ),
                ]),
                rowInput([
                  CustomFormInput(
                    controller: controller.addressCtrl,
                    labelText: 'Địa chỉ nơi ở',
                  ),
                ]),
                rowInput([
                  CustomPickerInput(
                    controller: controller.groupCtrl,
                    mainContext: context,
                    label: 'Nhóm đối tượng',
                  ),
                  CustomFormInput(
                    controller: controller.unitCtrl,
                    labelText: 'Đơn vị công tác',
                  ),
                ]),
                rowInput([
                  CustomPickerInput(
                    controller: controller.csytCtrl,
                    mainContext: context,
                    label: 'Cơ sở y tế',
                  ),
                  CustomPickerInput(
                    controller: controller.localCtrl,
                    mainContext: context,
                    label: 'Địa bàn cơ sở',
                  ),
                ]),
                rowInput([
                  CustomPickerInput(
                    controller: controller.danTocCtrl,
                    mainContext: context,
                    label: 'Dân tộc',
                  ),
                  CustomPickerInput(
                    controller: controller.quocTichCtrl,
                    mainContext: context,
                    label: 'Quốc tịch',
                  ),
                ]),
                rowInput([
                  CustomFormInput(
                    controller: controller.tieuSuCtrl,
                    labelText: 'Tiểu sử dị ứng',
                  ),
                ]),
                rowInput([
                  CustomFormInput(
                    controller: controller.benhLyCtrl,
                    labelText: 'Các bệnh lý đang mắc',
                  ),
                  CustomFormInput(
                    controller: controller.thuocCtrl,
                    labelText: 'Các thuốc đang dùng',
                  ),
                ]),
                rowInput([
                  CustomDateInput(
                    controller: controller.ngayDKCtrl,
                    label: 'Ngày đăng ký tiêm',
                  ),
                  CustomFormInput(
                    controller: controller.luuYCtrl,
                    labelText: 'Lưu ý',
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
