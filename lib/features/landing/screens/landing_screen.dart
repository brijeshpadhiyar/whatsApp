import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:whatsapp/common/widgets/custom_button.dart';
import 'package:whatsapp/core/constants/constants.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Text(
              "Welcome to WhatsApp",
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 100.h / 9),
            Image.asset(
              AppImages.obBg,
              width: 340,
              height: 340,
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
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    ));
  }
}
