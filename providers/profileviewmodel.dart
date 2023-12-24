import 'package:flutter/material.dart';

import '../repositories/user_reponsitory.dart';

class ProfileViewModel with ChangeNotifier {
  int status = 0;
  int modified = 0;
  int updatedavatar = 0;
  void updatescreen() {
    status = 0;
    notifyListeners();
  }

  void displaySpinner() {
    status = 1;
    notifyListeners();
  }

  void setModified() {
    if (modified == 0) {
      modified = 1;
      notifyListeners();
    }
  }

  void hideSpinner() {
    status = 0;
    notifyListeners();
  }

  Future<void> updateProfile() async {
    status = 1;
    notifyListeners();
    await UserRepository().updateProfile();
    status = 0;
    modified = 0;
    notifyListeners();
  }
}
