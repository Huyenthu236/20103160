import 'package:connection2/repositories/register.repository.dart';
import 'package:flutter/material.dart';

class RegisterViewModel with ChangeNotifier {
  int status =
      0; //0-ch đki, 1 -đang đki, 2 -đki lỗi, 3 -dk cần xm email, 4 - dk ko cần xm email
  String errormessage = "";
  bool agree = false;
  final registerRepo = RegisterRepository();
  String quydinh =
      "Khi tham gia vào ứng dụng các bạn đồng ý các điều khoản sau:\n1. Các thông tin của bạn sẽ được chia sẻ với các thành viên\n2. Thông tin của bạn có thể ảnh hưởng học tập ở trường\n3. Thông tin của bạn sẽ được xóa vĩnh viễn khi có yêu cầu xóa thông tin";
  void setAgree(bool value) {
    agree = value;
    notifyListeners();
  }

  Future<void> register(
      String email, String username, String pass1, String pass2) async {
    status = 1;
    notifyListeners();
    errormessage = "";
    if (agree == false) {
      status = 2;
      errormessage += "Bạn phải đồng ý điều khoản trước khi đăng ký!\n";
    }
    if (email.isEmpty || username.isEmpty || pass1.isEmpty) {
      status = 2;
      errormessage += "Email, username, password ko được để trống\n";
    }
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (emailValid == false) {
      status = 2;
      errormessage += "Email ko hợp lệ!\n";
    }
    if (pass1.length < 8) {
      status = 2;
      errormessage += "Password cần lớn hơn 8 chữ\n";
    }
    if (pass1 != pass2) {
      status = 2;
      errormessage = "mật khẩu ko giống nhau!";
    }
    if (status != 2) {
      status = await registerRepo.register(email, username, pass1);
    }
    // su dụng repository gọi hàm login và lấy kết quả
    notifyListeners();
  }
}
