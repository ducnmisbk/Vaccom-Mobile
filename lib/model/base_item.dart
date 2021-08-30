import 'package:vaccom_mobile/components/custom_picker_input/custom_picker_input_controller.dart';

abstract class BaseItem {
  int id, parentID;
  String code, name;

  static List<PickerItem> parsePicker(List<BaseItem> data) =>
      data.map((x) => PickerItem(title: x.name, value: x.code)).toList();
}