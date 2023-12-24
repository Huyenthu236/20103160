import 'package:connection2/providers/diachimodel.dart';
import 'package:connection2/providers/mainviewmodel.dart';
import 'package:connection2/providers/profileviewmodel.dart';
import 'package:connection2/ui/AppConstant.dart';
import 'package:connection2/ui/custom_control.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../model/profile.dart';

class SubPageProfile extends StatelessWidget {
  const SubPageProfile({super.key});
  static int idpage = 1;

  Future<void> init(DiachiModel dcmodel, ProfileViewModel viewmodel) async {
    Profile profile = Profile();

    if (dcmodel.listCity.isEmpty ||
        dcmodel.curCityId != profile.user.provinceid ||
        dcmodel.curDistId != profile.user.districtid ||
        dcmodel.curWardId != profile.user.wardid) {
      viewmodel.displaySpinner();
      await dcmodel.initialize(profile.user.provinceid, profile.user.districtid,
          profile.user.wardid);
      print('--finished--init ---');
      viewmodel.hideSpinner();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ProfileViewModel>(context);
    final dcmodel = Provider.of<DiachiModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    Future.delayed(Duration.zero, () => init(dcmodel, viewmodel));

    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: [
                //--start header --//
                createHeader(size, profile, viewmodel),
                //end header...
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomInputTextFormField(
                            title: 'Điện thoại',
                            value: profile.user.phone,
                            width: size.width * 0.45,
                            callback: (output) {
                              profile.user.phone = output;
                              viewmodel.setModified();
                              viewmodel.updatescreen();
                            },
                            type: TextInputType.phone,
                          ),
                          CustomInputTextFormField(
                            title: 'Ngày sinh ',
                            value: profile.user.birthday,
                            width: size.width * 0.45,
                            callback: (output) {
                              if (AppConstant.isDate(output)) {
                                profile.user.birthday = output;
                              }
                              viewmodel.updatescreen();
                            },
                            type: TextInputType.datetime,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomPlaceDropDown(
                              width: size.width * 0.45,
                              title: 'Thành phố/tỉnh',
                              valueId: profile.user.provinceid,
                              valueName: profile.user.provincename,
                              callback: (outputId, outputName) async {
                                viewmodel.displaySpinner();
                                profile.user.provinceid = outputId;
                                profile.user.provincename = outputName;
                                await dcmodel.setCity(outputId);
                                profile.user.districtid = 0;
                                profile.user.wardid = 0;
                                profile.user.districtname = "";
                                profile.user.wardname = "";
                                viewmodel.setModified();
                                viewmodel.hideSpinner();
                              },
                              list: dcmodel.listCity),
                          CustomPlaceDropDown(
                              width: size.width * 0.45,
                              title: 'Quận/huyện',
                              valueId: profile.user.districtid,
                              valueName: profile.user.districtname,
                              callback: (outputId, outputName) async {
                                viewmodel.displaySpinner();
                                profile.user.districtid = outputId;
                                profile.user.districtname = outputName;
                                await dcmodel.setDistrict(outputId);
                                viewmodel.setModified();
                                viewmodel.hideSpinner();
                              },
                              list: dcmodel.listDistrict),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomPlaceDropDown(
                              width: size.width * 0.45,
                              title: 'Thành phố/tỉnh',
                              valueId: profile.user.wardid,
                              valueName: profile.user.wardname,
                              callback: (outputId, outputName) async {
                                viewmodel.displaySpinner();
                                profile.user.wardid = outputId;
                                profile.user.wardname = outputName;
                                await dcmodel.setWard(outputId);
                                viewmodel.hideSpinner();
                              },
                              list: dcmodel.listWard),
                          CustomInputTextFormField(
                            title: 'Tên đường/số nhà',
                            value: profile.user.address,
                            width: size.width * 0.45,
                            callback: (output) {
                              profile.user.address = output;
                              viewmodel.updatescreen();
                            },
                            type: TextInputType.streetAddress,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: size.width * 0.3,
                        width: size.width * 0.3,
                        child: QrImageView(
                          data: '{userid:' + profile.user.id.toString() + '}',
                          version: QrVersions.auto,
                          gapless: false,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            viewmodel.status == 1 ? CustomSpinner(size: size) : Container(),
          ],
        ),
      ),
    );
  }

  Container createHeader(
      Size size, Profile profile, ProfileViewModel viewModel) {
    XFile? image;
    return Container(
      height: size.height * 0.20,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppConstant.appbarcolor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(
                    profile.student.diem.toString(),
                    style: AppConstant.textbodywhite,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: () async {
                      final ImagePicker _picker = ImagePicker();
                      image =
                          await _picker.pickImage(source: ImageSource.gallery);
                    },
                    child: CustomAvatar(size: size)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.user.firts_name,
                style: AppConstant.textbodyfocuswhite,
              ),
              Row(
                children: [
                  Text(
                    'Mssv:',
                    style: AppConstant.textbodywhite,
                  ),
                  Text(
                    profile.student.mssv,
                    style: AppConstant.textbodywhitebold,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Lớp:',
                    style: AppConstant.textbodywhite,
                  ),
                  Text(
                    profile.student.tenlop,
                    style: AppConstant.textbodywhitebold,
                  ),
                  profile.student.duyet == 0
                      ? Text(
                          "(chưa duyệt)",
                          style: AppConstant.textbodywhite,
                        )
                      : Text(''),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Vai trò: ',
                    style: AppConstant.textbodywhite,
                  ),
                  profile.user.role_id == 4
                      ? Text(
                          'sinh viên',
                          style: AppConstant.textbodywhitebold,
                        )
                      : Text(
                          'giảng viên',
                          style: AppConstant.textbodywhitebold,
                        ),
                ],
              ),
              SizedBox(
                width: size.width * 0.4,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: viewModel.modified == 1
                        ? GestureDetector(
                            onTap: () {
                              viewModel.updateProfile();
                            },
                            child: Icon(Icons.save))
                        : Container()),
              )
            ],
          )
        ],
      ),
    );
  }
}
