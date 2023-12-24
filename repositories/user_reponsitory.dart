import 'package:connection2/model/user.dart';
import 'package:connection2/services/api_sevice.dart';

class UserRepository {
  Future<User> getUserInfo() async {
    User user = User();
    final response = await ApiService().getStudentInfo();
    if (response != null) {
      var json = response.data['data'];
      user = User.fromjson(json);
    }
    return user;
  }

  Future<bool> updateProfile() async {
    bool kq = false;
    var response = await ApiService().updateProfile();
    if (response != null) {
      kq = true;
    }
    return kq;
  }
}
