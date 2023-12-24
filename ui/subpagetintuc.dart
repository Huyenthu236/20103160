import 'package:connection2/providers/mainviewmodel.dart';
import 'package:connection2/ui/AppConstant.dart';
import 'package:flutter/material.dart';

class SubPageTintuc extends StatelessWidget {
  const SubPageTintuc({super.key});
  static int idpage = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => MainViewModel().closeMenu(),
        child: Container(
            color: AppConstant.backgroundcolor,
            child: const Center(
              child: Text("Tintuc"),
            )));
  }
}
