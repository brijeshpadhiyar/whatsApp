// ignore_for_file: use_build_context_synchronously

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:whatsapp/utils/utils.dart';
import 'package:whatsapp/common/widgets/custom_button.dart';
import 'package:whatsapp/core/constants/constants.dart';
import 'package:whatsapp/core/routes/routes.dart';
import 'package:whatsapp/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  Country? _country;

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  void _pickCountry() {
    showCountryPicker(
      context: context,
      onSelect: (country) {
        setState(() {
          _country = country;
        });
      },
    );
  }

  void _sendPhoneNumber() {
    String phoneNumber = _phoneController.text.trim();
    if (_country != null && phoneNumber.isNotEmpty) {
      ref.read(authControllerProvider).signInWithPhone(context, "+${_country!.phoneCode}$phoneNumber");
    } else {
      showSnackbar(context: context, content: "Fill out all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Enter your phone number"),
          elevation: 0,
          backgroundColor: AppColor.backgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Whatsapp will need to verify your phone number."),
              SizedBox(height: 1.h),
              TextButton(
                onPressed: _pickCountry,
                child: const Text("Pick Country"),
              ),
              SizedBox(height: 0.5.h),
              Row(
                children: [
                  if (_country != null) Text("+${_country!.phoneCode}"),
                  SizedBox(width: 10.w),
                  SizedBox(
                    width: 70.w,
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "phone number",
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () async {
                  bool? done = await ref.read(authControllerProvider).signInWithGoogle(context);
                  if (done == true) {
                    context.go(AppRoutes.userInfoScreen);
                  }
                },
                icon: Image.asset(
                  AppImages.google,
                  height: 3.h,
                  width: 3.h,
                ),
                label: const Text("Google login"),
              ),
              const Spacer(),
              SizedBox(
                width: 40.w,
                child: CustomButton(
                  text: "NEXT",
                  onPressed: _sendPhoneNumber,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
