import 'package:connection2/model/profile.dart';
import 'package:connection2/repositories/lop_repository.dart';
import 'package:connection2/repositories/user_reponsitory.dart';
import 'package:connection2/ui/AppConstant.dart';
import 'package:connection2/ui/custom_control.dart';
import 'package:connection2/ui/page_main.dart';
import 'package:flutter/material.dart';

import '../model/lop.dart';
import '../repositories/student_repository.dart';

class PageDangKylop extends StatefulWidget {
  const PageDangKylop({super.key});

  @override
  State<PageDangKylop> createState() => _PageDangKylopState();
}

class _PageDangKylopState extends State<PageDangKylop> {
  List<Lop>? listlop = [];
  Profile profile = Profile();
  String mssv = '';
  String ten = '';
  int idlop = 0;
  String tenlop = '';

  @override
  void initState() {
    mssv = profile.student.mssv;
    ten = profile.user.firts_name;
    idlop = profile.student.idLop;
    tenlop = profile.student.tenlop;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Thêm thông tin cơ bản',
                style: AppConstant.textfancyheader,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Bạn không thể quay trở lại trang sau khi rời đi',
                style: AppConstant.texterror,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputTextFormField(
                title: "Tên",
                value: ten,
                width: size.width,
                callback: (output) {
                  ten = output;
                },
              ),
              CustomInputTextFormField(
                title: "Mssv",
                value: mssv,
                width: size.width,
                callback: (output) {
                  mssv = output;
                },
              ),
              listlop!.isEmpty
                  ? FutureBuilder(
                      future: LopRepository().getDsLop(),
                      builder: (context, AsyncSnapshot<List<Lop>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          listlop = snapshot.data;
                          return CustomInputDropDown(
                            width: size.width,
                            list: listlop!,
                            title: "Lớp",
                            valueId: idlop,
                            valueName: tenlop,
                            callback: ((outputId, outputName) {
                              idlop = outputId;
                              tenlop = outputName;
                            }),
                          );
                        } else {
                          return const Text('lỗi xảy ra');
                        }
                      },
                    )
                  : CustomInputDropDown(
                      width: size.width,
                      list: listlop!,
                      title: "Lớp",
                      valueId: idlop,
                      valueName: tenlop,
                      callback: (outputId, outputName) {
                        idlop = outputId;
                        tenlop = outputName;
                      },
                    ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () async {
                    profile.student.mssv = mssv;
                    profile.student.idLop = idlop;
                    profile.student.tenlop = tenlop;
                    profile.user.firts_name = ten;
                    await UserRepository().updateProfile();
                    await StudentRepository().danglyLop();
                  },
                  child: const CustomButton(textButton: 'Lưu thông tin')),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, PageMain.routname);
                },
                child: Text(
                  "Rời khỏi trang >>",
                  style: AppConstant.textlink,
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
