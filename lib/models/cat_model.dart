import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CatModel {
  String text;
  IconData iconData;
  bool isSelected;

  CatModel({this.iconData, this.text, this.isSelected = false});

  void toggleCategory() {
    isSelected = !isSelected;
    if (kDebugMode) {
      print(isSelected);
    }
  }
}
