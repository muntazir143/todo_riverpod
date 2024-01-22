import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_riverpod/core/utils/core_utils.dart';
import 'package:todo_riverpod/features/authentication/views/otp_verification_screen.dart';

class AuthenticationRepository {
  const AuthenticationRepository({required this.auth});

  final FirebaseAuth auth;

  Future<void> sendOTP(
      {required BuildContext context, required String phoneNumber}) async {
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) {
          auth.signInWithCredential(credential);
        },
        verificationFailed: (exception) {
          CoreUtils.showSnackBar(
              context: context, message: '${exception.message}');
        },
        codeSent: (verificationId, _) {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const OTPVerificationScreen()));
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }
}
