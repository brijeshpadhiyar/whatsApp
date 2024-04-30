import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/common/widgets/error_screen.dart';
import 'package:whatsapp/common/widgets/loader.dart';
import 'package:whatsapp/features/auth/controller/auth_controller.dart';
import 'package:whatsapp/features/landing/screens/landing_screen.dart';
import 'package:whatsapp/screens/mobile_screen_layout.dart';

class OnBordingScreen extends ConsumerWidget {
  const OnBordingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userCeckProvider).when(
        data: (data) {
          if (data == null) {
            return const LandingScreen();
          }
          return const MobileScreenLayout();
        },
        error: (error, stackTrace) {
          return ErrorScreen(error: error.toString());
        },
        loading:()=> const Loader());
  }
}
