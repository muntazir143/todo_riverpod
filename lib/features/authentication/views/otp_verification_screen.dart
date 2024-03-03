import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_riverpod/core/common/widgets/white_space.dart';
import 'package:todo_riverpod/core/res/image_res.dart';
import 'package:todo_riverpod/core/utils/core_utils.dart';
import 'package:todo_riverpod/features/authentication/controller/authentication_controller.dart';

class OTPVerificationScreen extends ConsumerWidget {
  const OTPVerificationScreen({super.key, required this.verificationId});

  final String verificationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageRes.todo),
              const WhiteSpace(height: 30),
              Pinput(
                length: 6,
                onCompleted: (pin) async {
                  CoreUtils.showLoader(context);
                  await ref.read(authControllerProvider).verifyOTP(
                        context: context,
                        verificationId: verificationId,
                        otp: pin,
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
