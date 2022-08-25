import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proplus/utils.dart';
import 'package:proplus/view/loginscreen.dart';

import 'package:proplus/viewmodel/loginviewmodel.dart';
import 'package:proplus/viewmodel/productlistviewmodel.dart';
import 'package:provider/provider.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginViewModel>(create: (_) => LoginViewModel()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Pro plusDemo',
                scaffoldMessengerKey: Utils.messengerKey,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: const LoginScreen(),
              );
          }),
    );
  }
}
