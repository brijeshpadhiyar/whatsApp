import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/features/landing/screens/landing_screen.dart';
import 'package:whatsapp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Whatsapp',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColor.backgroundColor,
            colorScheme: const ColorScheme.dark(),
            brightness: Brightness.dark,
          ),
          home: const LandingScreen()
        );
      }
    );
  }
}
