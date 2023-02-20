import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta_gate_test/constants/app_colors.dart';
import 'package:meta_gate_test/views/devices.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor
      ),
      home: DevicesScreen(),
    );
  }
}
