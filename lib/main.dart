// ignore_for_file: deprecated_member_use

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/core/routes/routes.dart';
import 'package:whatsapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        title: 'Whatsapp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: AppColor.backgroundColor,
            colorScheme: const ColorScheme.dark(),
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(
              color: AppColor.appBarColor,
            )),
        routerConfig: AppRoutes.router,
      );
    });
  }
}
