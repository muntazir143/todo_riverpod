import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/features/authentication/repository/authentication_repository.dart';

final authControllerProvider =
    Provider((ref) => AuthenticationController(ref.watch(authRepoProvider)));

class AuthenticationController {
  const AuthenticationController(this.repository);

  final AuthenticationRepository repository;

  Future<void> sendOTP(
      {required BuildContext context, required String phoneNumber}) async {
    return repository.sendOTP(context: context, phoneNumber: phoneNumber);
  }

  Future<void> verifyOTP(
      {required BuildContext context,
      required String verificationId,
      required String otp}) async {
    return repository.verifyOTP(
        context: context, verificationId: verificationId, otp: otp);
  }
}
