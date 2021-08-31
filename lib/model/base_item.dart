import 'package:vaccom_mobile/components/custom_picker_input/custom_picker_input_controller.dart';

class BaseItem {
  int id, parentID;
  String code, name;

  BaseItem({this.id, this.name, this.code});

  static List<PickerItem> parsePicker(List<BaseItem> data) =>
      data.map((x) => PickerItem(title: x.name, value: x.id)).toList();
}