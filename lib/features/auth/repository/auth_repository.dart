// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whatsapp/common/repositores/common_firebase_storage_repo.dart';
import 'package:whatsapp/models/user_model.dart';
import 'package:whatsapp/utils/utils.dart';
import 'package:whatsapp/core/routes/routes.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance);
});

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  Future<UserModel?> getCurrentUserData() async {
    UserModel? userModel;
    var userData = await _firestore.collection("users").doc(_auth.currentUser!.uid).get();
    if (userData.data() != null) {
      userModel = UserModel.fromMap(userData.data()!);
    }
    return userModel;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          await _auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) async {
          GoRouter.of(context).push(AppRoutes.otpScreen, extra: verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (error) {
      showSnackbar(context: context, content: error.message!);
    }
  }

  Future<bool?> verifyOTP({required BuildContext context, required String id, required String userOtp}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: id,
        smsCode: userOtp,
      );
      await _auth.signInWithCredential(credential);
      return true;
    } on FirebaseAuthException catch (error) {
      showSnackbar(context: context, content: error.message!);
      return false;
    }
  }

  Future<bool?> signInWithGoogle(BuildContext context) async {
    BuildContext? scaffoldContext = ScaffoldMessenger.of(context).context;

    try {
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);

      return true;
    } on FirebaseAuthException catch (error) {
      showSnackbar(context: scaffoldContext, content: error.message!);
      return false;
    }
  }

  void saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = _auth.currentUser!.uid;
      String profileUrl =
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3Uvz1u9OEAyfa73f7mcAW8cV_-YQIN063X9Ozsdl4UA&s";
      if (profilePic != null) {
        profileUrl =
            await ref.read(commonFirebaseStorageRepositoryProvider).storeFileToFirebase("profilePic/$uid", profilePic);
      }
      UserModel user = UserModel(
        name: name,
        uid: uid,
        profilePic: profileUrl,
        isOnline: true,
        number: _auth.currentUser!.phoneNumber!,
        gropId: <String>[],
      );
      await _firestore.collection("users").doc(uid).set(user.toMap());
      context.go(AppRoutes.mobileScreen);
    } catch (error) {
      showSnackbar(context: context, content: error.toString());
    }
  }
}
