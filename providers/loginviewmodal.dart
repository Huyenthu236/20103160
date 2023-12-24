import 'package:connection2/model/student.dart';
import 'package:connection2/model/user.dart';
import 'package:connection2/repositories/login_repository.dart';
import 'package:connection2/repositories/student_repository.dart';
import 'package:connection2/repositories/user_reponsitory.dart';
import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  String errorMessage = "";
  int status = 0;
  // 0 out , 1 wait, 2 error, 3 logged
  LoginRepository loginRepo = LoginRepository();
  Future<void> login(String username, String password) async {
    status = 1;
    notifyListeners();
    try {
      var profile = await loginRepo.login(username, password);
      if (profile.token == "") {
        status = 2;
        errorMessage = "Email hoặc Password sai!";
      } else {
        status = 3;
        //dang nhap thanh cong, lay thong tin
        var student = await StudentRepository().getStudentInfo();
        profile.student = Student.fromStudent(student);
        var user = await UserRepository().getUserInfo();
        profile.user = User.fromUser(user);
      }
      notifyListeners();
    } catch (e) {}
  }
}
