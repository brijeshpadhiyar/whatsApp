import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp/features/auth/screens/login_screen.dart';
import 'package:whatsapp/features/auth/screens/otp_screen.dart';
import 'package:whatsapp/features/auth/screens/user_info_screen.dart';
import 'package:whatsapp/features/landing/screens/landing_screen.dart';
import 'package:whatsapp/screens/mobile_chat_screen.dart';

class AppRoutes {
  static const String loginScreen = "/login-screen";
  static const String otpScreen = "/otp-screen";
  static const String userInfoScreen = "/user-info";
  static const String mobileScreen = "/mobile-screen";


  static final router = GoRouter(routes: [
    GoRoute(
        path: "/",
        pageBuilder: (context, state) {
          return _builder(const LandingScreen());
        }),
    GoRoute(
        path: loginScreen,
        pageBuilder: (context, state) {
          return _builder(const LoginScreen());
        }),
    GoRoute(
        path: otpScreen,
        pageBuilder: (context, state) {
          final id = state.extra as String;
          return _builder(OTPScreen(
            verificationId: id,
          ));
        }),
    GoRoute(
        path: userInfoScreen,
        pageBuilder: (context, state) {
          return _builder(const UserInfoScreen());
        }),
        GoRoute(
        path: mobileScreen,
        pageBuilder: (context, state) {
          return _builder(const MobileChatScreen());
        }),
  ]);

  static _builder(Widget widget) {
    return CupertinoPage(child: widget);
  }
}
