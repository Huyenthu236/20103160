import 'package:flutter/material.dart';

class MenuBarViewModel with ChangeNotifier {
  Offset offset = const Offset(0, 0);
  void setOffset(Offset offset) {
    this.offset = offset;
    notifyListeners();
  }
}
