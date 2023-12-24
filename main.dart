import 'package:connection2/model/profile.dart';
import 'package:connection2/providers/diachimodel.dart';
import 'package:connection2/providers/forgotviewmodel.dart';
import 'package:connection2/providers/loginviewmodal.dart';
import 'package:connection2/providers/mainviewmodel.dart';
import 'package:connection2/providers/menubarviewmodel.dart';
import 'package:connection2/services/api_sevice.dart';
import 'package:connection2/ui/page_dklop.dart';
import 'package:connection2/ui/page_fogot.dart';
import 'package:connection2/ui/page_main.dart';
import 'package:connection2/ui/page_register.dart';
import 'package:connection2/ui/subpageprofile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/profileviewmodel.dart';
import 'providers/registerviewmodel.dart';
import 'ui/page_login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiService api = ApiService();
  api.initialize();
  Profile profile = Profile();
  profile.initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(),
    ),
    ChangeNotifierProvider<RegisterViewModel>(
      create: (context) => RegisterViewModel(),
    ),
    ChangeNotifierProvider<ForgotViewModel>(
      create: (context) => ForgotViewModel(),
    ),
    ChangeNotifierProvider<MainViewModel>(
      create: (context) => MainViewModel(),
    ),
    ChangeNotifierProvider<ProfileViewModel>(
      create: (context) => ProfileViewModel(),
    ),
    ChangeNotifierProvider<MenuBarViewModel>(
      create: (context) => MenuBarViewModel(),
    ),
    ChangeNotifierProvider<DiachiModel>(
      create: (context) => DiachiModel(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => PageMain(),
        '/login': (context) => PageLogin(),
        '/register': (context) => PageRegister(),
        '/forgot': (context) => Pageforgot(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent),
        useMaterial3: true,
      ),
      home: PageMain(),
    );
  }
}
