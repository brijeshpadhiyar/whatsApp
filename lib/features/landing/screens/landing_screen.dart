import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:whatsapp/common/widgets/custom_button.dart';
import 'package:whatsapp/core/constants/constants.dart';
import 'package:whatsapp/core/routes/routes.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigator() {
      GoRouter.of(context).push(AppRoutes.loginScreen);
    }

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 5.h),
              Text(
                "Welcome to WhatsApp",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 100.h / 9),
              Image.asset(
                AppImages.obBg,
                width: 40.h,
                height: 40.h,
                color: AppColor.tabColor,
              ),
              SizedBox(height: 100.h / 9),
              const Text(
                maxLines: 2,
                textAlign: TextAlign.center,
                'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                style: TextStyle(color: AppColor.greyColor),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                width: 70.5.w,
                child: CustomButton(
                  text: "AGREE AND CONTINUE",
                  onPressed: () => navigator(),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
