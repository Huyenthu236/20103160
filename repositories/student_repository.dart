import 'package:connection2/model/student.dart';
import 'package:connection2/services/api_sevice.dart';

class StudentRepository {
  final ApiService api = ApiService();
  Future<bool> danglyLop() async {
    bool kq = false;
    var response = await api.dangkyLop();
    if (response != null) {
      kq = true;
    }
    return kq;
  }

  Future<Student> getStudentInfo() async {
    Student student = Student();
    var response = await api.getStudentInfo();
    if (response != null) {
      var data = response.data;
      student = Student.fromJson(data);
      //Profile().student = Student.fromStudent(student);
    }
    return student;
  }
}
