import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/common/widgets/filled_field.dart';
import 'package:todo_riverpod/core/common/widgets/round_button.dart';
import 'package:todo_riverpod/core/common/widgets/white_space.dart';
import 'package:todo_riverpod/core/res/color_res.dart';
import 'package:todo_riverpod/core/res/image_res.dart';
import 'package:todo_riverpod/core/utils/core_utils.dart';
import 'package:todo_riverpod/features/authentication/app/country_code_provider.dart';
import 'package:todo_riverpod/features/authentication/controller/authentication_controller.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final code = ref.watch(countryCodeProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            physics: const PageScrollPhysics(),
            shrinkWrap: true,
            children: [
              Image.asset(ImageRes.todo),
              const WhiteSpace(height: 20),
              Text(
                'Please enter you number to verify',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  color: ColorsRes.light,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const WhiteSpace(height: 20),
              FilledField(
                controller: phoneController,
                readOnly: code == null,
                keyboardType: TextInputType.phone,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        onSelect: (code) {
                          ref
                              .read(countryCodeProvider.notifier)
                              .changeCountry(code);
                        },
                        countryListTheme: CountryListThemeData(
                          backgroundColor: ColorsRes.darkBackground,
                          bottomSheetHeight:
                              MediaQuery.of(context).size.height * .6,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          textStyle: GoogleFonts.poppins(
                            color: ColorsRes.light,
                          ),
                          searchTextStyle: GoogleFonts.poppins(
                            color: ColorsRes.light,
                          ),
                          inputDecoration: InputDecoration(
                            hintText: 'Search',
                            labelText: 'Search',
                            hintStyle: GoogleFonts.poppins(
                              color: ColorsRes.light,
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: code == null ? 6.h : 1.5.h),
                      child: Text(
                        code == null
                            ? 'Pick country'
                            : '${code.flagEmoji} +${code.phoneCode} ',
                        style: GoogleFonts.poppins(
                          fontSize: code == null ? 13 : 18,
                          color: code == null
                              ? Colors.lightBlueAccent
                              : ColorsRes.darkBackground,
                          fontWeight:
                              code == null ? FontWeight.w500 : FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const WhiteSpace(height: 20),
              RoundButton(
                text: 'Send Code',
                onPressed: () async {
                  if (code == null) return;
                  CoreUtils.showLoader(context);
                  final navigator = Navigator.of(context);
                  await ref.read(authControllerProvider).sendOTP(
                      context: context,
                      phoneNumber: '+${code.phoneCode}${phoneController.text}');
                  navigator.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
