import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AppConstant {
  static TextStyle textfancyheader =
      GoogleFonts.flavors(fontSize: 40, color: Colors.yellow);

  static TextStyle texterror = TextStyle(
      color: Colors.red[300], fontSize: 16, fontStyle: FontStyle.italic);

  static TextStyle textlink = const TextStyle(color: Colors.greenAccent);

  static TextStyle textbody =
      const TextStyle(color: Colors.amber, fontSize: 16);

  static TextStyle textbodywhite =
      const TextStyle(color: Colors.white, fontSize: 16);

  static TextStyle textbodywhitebold =
      const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  static TextStyle textbodyfocus =
      const TextStyle(color: Colors.greenAccent, fontSize: 20);

  static TextStyle textbodyfocuswhite =
      const TextStyle(color: Colors.white, fontSize: 20);

  static bool isDate(String str) {
    try {
      var inputFormat = DateFormat('dd/MM/yyyy');
      var date1 = inputFormat.parseStrict(str);
      return true;
    } catch (e) {
      print('---lỗi---');
      return false;
    }
  }

  static Color appbarcolor = Colors.amber;
  static Color? backgroundcolor = Colors.amber[200];
}
