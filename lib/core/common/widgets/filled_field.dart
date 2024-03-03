import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_riverpod/core/res/color_res.dart';

class FilledField extends StatelessWidget {
  const FilledField(
      {super.key,
      this.readOnly = false,
      this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.hintText,
      this.keyboardType});

  final TextEditingController? controller;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(16));
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.poppins(
        fontSize: 18,
        color: ColorsRes.darkBackground,
        fontWeight: FontWeight.bold,
      ),
      readOnly: readOnly,
      decoration: InputDecoration(
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        fillColor: ColorsRes.light,
        focusedBorder: border,
        enabledBorder: border,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
      ),
    );
  }
}
