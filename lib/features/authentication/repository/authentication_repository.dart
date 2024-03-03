import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/helper/db_helper.dart';
import 'package:todo_riverpod/core/utils/core_utils.dart';
import 'package:todo_riverpod/features/authentication/views/otp_verification_screen.dart';
import 'package:todo_riverpod/features/todo/views/home_screen.dart';

final authRepoProvider =
    Provider((ref) => AuthenticationRepository(auth: FirebaseAuth.instance));

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
        debugPrint(exception.message);
        CoreUtils.showSnackBar(
            context: context, message: '${exception.message}');
      },
      codeSent: (verificationId, _) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    OTPVerificationScreen(verificationId: verificationId)));
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future<void> verifyOTP(
      {required BuildContext context,
      required String verificationId,
      required String otp}) async {
    try {
      void showSnack() =>
          CoreUtils.showSnackBar(context: context, message: 'Error');
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);

      final navigator = Navigator.of(context);

      final userCredential = await auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        await DBHelper.createUser(isVerified: true);
        navigator.pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
            (route) => false);
      } else {
        showSnack();
      }
    } on FirebaseException catch (e) {
      CoreUtils.showSnackBar(context: context, message: '${e.message}');
    } catch (e) {
      CoreUtils.showSnackBar(context: context, message: 'Error');
    }
  }
}
