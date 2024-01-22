import 'package:flutter/material.dart';
import 'package:todo_riverpod/features/authentication/repository/authentication_repository.dart';

class AuthenticationController {
  const AuthenticationController(this.repository);

  final AuthenticationRepository repository;

  Future<void> sendOTP(
      {required BuildContext context, required String phoneNumber}) async {
    return repository.sendOTP(context: context, phoneNumber: phoneNumber);
  }
}
