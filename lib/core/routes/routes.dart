import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:whatsapp/features/auth/screens/login_screen.dart';
import 'package:whatsapp/features/auth/screens/otp_screen.dart';
import 'package:whatsapp/features/auth/screens/user_info_screen.dart';
import 'package:whatsapp/features/landing/screens/on_bording_screen.dart';
import 'package:whatsapp/features/selectContacts/screens/select_contact_screen.dart';
import 'package:whatsapp/screens/mobile_screen_layout.dart';

class AppRoutes {
  static const String loginScreen = "/login-screen";
  static const String otpScreen = "/otp-screen";
  static const String userInfoScreen = "/user-info";
  static const String mobileScreen = "/mobile-screen";
  static const String selectContactScreen = "/select-contact";

  static final router = GoRouter(initialLocation: "/", routes: [
        GoRoute(
            path: "/",
            pageBuilder: (context, state) {
              return _builder(const OnBordingScreen());
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
              return _builder(const MobileScreenLayout());
            }),
        GoRoute(
            path: selectContactScreen,
            pageBuilder: (context, state) {
              return _builder(const SelectContactScreen());
            }),
      ]);

  static _builder(Widget widget) {
    return CupertinoPage(child: widget);
  }
}
