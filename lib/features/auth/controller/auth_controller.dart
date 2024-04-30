import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp/features/auth/repository/auth_repository.dart';
import 'package:whatsapp/models/user_model.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataProvider = FutureProvider<UserModel?>((ref) async {
  return await ref.watch(authControllerProvider).getCurrentUserData();
});

final userCeckProvider = FutureProvider<User?>((ref) {
  return ref.watch(authControllerProvider).userCeck();
});

class AuthController {
  final AuthRepository _authRepository;
  final ProviderRef _ref;
  AuthController({required AuthRepository authRepository, required ProviderRef ref})
      : _authRepository = authRepository,
        _ref = ref;

  Future<User?> userCeck() async {
    return await _authRepository.userCeck();
  }

  Future<UserModel?> getCurrentUserData() async {
    UserModel? user = await _authRepository.getCurrentUserData();
    return user;
  }

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
