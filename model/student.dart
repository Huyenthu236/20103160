class Student {
  int iduser;
  String mssv;
  int idLop;
  String tenlop;
  int diem;
  int duyet;
  Student(
      {this.iduser = 0,
      this.mssv = "",
      this.idLop = 0,
      this.tenlop = "",
      this.diem = 0,
      this.duyet = 0});
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        iduser: json['iduser'],
        mssv: json['mssv'],
        idLop: json['idLop'],
        tenlop: json['lop'],
        diem: json['diem'],
        duyet: json['duyet']);
  }
  factory Student.fromStudent(Student student) {
    return Student(
        iduser: student.iduser,
        mssv: student.mssv,
        idLop: student.idLop,
        tenlop: student.tenlop,
        diem: student.diem,
        duyet: student.duyet);
  }
}
