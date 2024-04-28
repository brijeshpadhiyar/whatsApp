import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository,ref: ref);
});

class AuthController {
  final AuthRepository _authRepository;
  final ProviderRef _ref;
  AuthController({required AuthRepository authRepository,required ProviderRef ref}) : _authRepository = authRepository,_ref = ref;

  void signInWithPhone(BuildContext context, String phoneNumber) {
    _authRepository.signInWithPhone(context, phoneNumber);
  }

  Future<bool?> verifyOTP({required BuildContext context, required String id, required String userOtp}) async {
    return await _authRepository.verifyOTP(context: context, id: id, userOtp: userOtp);
  }

  Future<bool?> signInWithGoogle(BuildContext context) async {
    return await _authRepository.signInWithGoogle(context);
  }

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required BuildContext context,
  }) {
    return _authRepository.saveUserDataToFirebase(name: name, profilePic: profilePic, ref: _ref, context: context);
  }
}
