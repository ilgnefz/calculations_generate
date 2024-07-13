import 'dart:io';

import 'package:calculations_generate/constants/key.dart';
import 'package:calculations_generate/utils/storage.dart';
import 'package:calculations_generate/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'provider/app.dart';

void main() async {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => const MaterialApp(
          title: '计算题生成',
          debugShowCheckedModeBanner: false,
          home: HomeView(),
        ),
      ),
    );
  }
}
