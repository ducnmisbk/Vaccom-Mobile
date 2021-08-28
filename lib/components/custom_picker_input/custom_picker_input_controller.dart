import 'package:flutter/material.dart';

class PickerItem {
  String title;
  dynamic value;
  PickerItem({
    this.title = '',
    this.value,
  });
}

class PickerController extends TextEditingController {
  List<PickerItem> listMap;
  PickerItem itemData;
  dynamic itemValue;

  // PickerItem get data => itemData;
  // dynamic get dataValue => itemValue;
  // List get listData => listMap;

  set listData(_listData) {
    listMap = _listData;
    itemValue = null;
    itemData = null;
    clear();
  }

  //value của item được chọn trong list
  set dataValue(dynamic _valueData) {
    if (_valueData != null && _valueData != '') {
      itemData = listMap.firstWhere((element) => element.value == _valueData,
          orElse: () => null);
      if (itemData != null) {
        itemValue = _valueData;
        text = itemData.title;
      } else {
        itemValue = _valueData;
        itemData = PickerItem(title: _valueData, value: _valueData);
        text = _valueData;
      }
    }
  }

  set dataValueCustom(_valueData) {
    itemValue = _valueData;
    itemData = PickerItem(title: _valueData, value: _valueData);
    text = _valueData;
  }

  PickerController({
    this.listMap,
  });
}
