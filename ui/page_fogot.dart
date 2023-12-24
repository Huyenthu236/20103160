import 'package:connection2/providers/forgotviewmodel.dart';
import 'package:connection2/ui/AppConstant.dart';
import 'package:connection2/ui/custom_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'page_login.dart';

class Pageforgot extends StatelessWidget {
  Pageforgot({super.key});
  static String routeName = "/forgot";
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ForgotViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blueGrey[300],
        body: SafeArea(
          child: Center(
            child: viewmodel.status == 3
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('assets/image/icon2.jpg'),
                          width: 100,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Gửi yêu cầu tạo mật khẩu thành công. Truy cập vào email và làm theo hướng dẫn",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                viewmodel.status = 0;
                                Navigator.popAndPushNamed(
                                    context, PageLogin.routename);
                              },
                              child: Text(
                                "Bấm vào đây",
                                style: AppConstant.textlink,
                              ),
                            ),
                            const Text(" để đăng nhập")
                          ],
                        )
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage('assets/image/icon3.jpg'),
                              width: 200,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                                "Hãy điền email để thực hiện quy trình tái tạo mật khẩu",
                                style: AppConstant.textlink),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextFied(
                                textController: _emailController,
                                hintText: "Email",
                                obscureText: false),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              viewmodel.errormessage,
                              style: AppConstant.texterror,
                            ),
                            GestureDetector(
                                onTap: () {
                                  final email = _emailController.text.trim();
                                  viewmodel.forgotPassword(email);
                                },
                                child: const CustomButton(
                                    textButton: 'Gửi yêu cầu')),
                          ],
                        ),
                      ),
                      viewmodel.status == 1
                          ? CustomSpinner(size: size)
                          : Container(),
                    ],
                  ),
          ),
        ));
  }
}
