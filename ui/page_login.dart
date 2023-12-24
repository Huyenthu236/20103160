import 'package:connection2/ui/AppConstant.dart';
import 'package:connection2/ui/page_fogot.dart';
import 'package:connection2/ui/page_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/loginviewmodal.dart';
import 'custom_control.dart';
import 'page_main.dart';

class PageLogin extends StatelessWidget {
  PageLogin({super.key});
  static String routename = '/login';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<LoginViewModel>(context);
    final size = MediaQuery.of(context).size;
    if (viewmodel.status == 3) {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.popAndPushNamed(context, PageMain.routname);
        },
      );
    }
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppLogo(),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Xin Chào",
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "chúng tôi rất nhớ bạn!",
                      style: TextStyle(color: Colors.yellow, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextFied(
                      hintText: "username",
                      textController: _emailController,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFied(
                      hintText: "password",
                      textController: _passwordController,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    viewmodel.status == 2
                        ? Text(viewmodel.errorMessage,
                            style: const TextStyle(color: Colors.red))
                        : const Text(""),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        String username = _emailController.text.trim();
                        String password = _passwordController.text.trim();
                        viewmodel.login(username, password);
                      },
                      child: const CustomButton(textButton: "đăng nhập"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Chưa có tài khoản?"),
                        GestureDetector(
                          onTap: () => Navigator.of(context)
                              .popAndPushNamed(PageRegister.routename),
                          child: Text(
                            " Đăng kí",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red[400]),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .popAndPushNamed(Pageforgot.routeName),
                      child: Text(
                        "Quên mật khẩu?",
                        style: AppConstant.textlink,
                      ),
                    )
                  ],
                ),
              ),
              viewmodel.status == 1 ? CustomSpinner(size: size) : Container(),
            ],
          ),
        ),
      )),
    );
  }
}
