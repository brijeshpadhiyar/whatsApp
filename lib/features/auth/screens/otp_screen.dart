import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:whatsapp/core/constants/colors.dart';
import 'package:whatsapp/core/routes/routes.dart';
import 'package:whatsapp/features/auth/controller/auth_controller.dart';

class OTPScreen extends ConsumerWidget {
  final String verificationId;
  const OTPScreen({super.key, required this.verificationId});

  Future<bool?> verifyOTP(WidgetRef ref, BuildContext context, String userOtp) async {
    return await ref.read(authControllerProvider).verifyOTP(context: context, id: verificationId, userOtp: userOtp);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigator() {
      context.go(AppRoutes.userInfoScreen);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify your number"),
        elevation: 0,
        backgroundColor: AppColor.backgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5.h),
          const Text("We have sent an SMS with a code."),
          SizedBox(
            width: 50.w,
            child: TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 6,
              onChanged: (value) async {
                if (value.length == 6) {
                  bool? done = await verifyOTP(ref, context, value.trim());
                  if (done == true) {
                    navigator();
                  }
                }
              },
              decoration: InputDecoration(
                  hintText: "- - - - - -",
                  hintStyle: TextStyle(
                    fontSize: 32.sp,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
