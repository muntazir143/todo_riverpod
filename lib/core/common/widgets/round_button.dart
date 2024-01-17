import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_riverpod/core/res/color_res.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {super.key, this.onPressed, required this.text, this.backgroundColour});

  final VoidCallback? onPressed;
  final String text;
  final Color? backgroundColour;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsRes.light,
        minimumSize: Size(size.width * .9, size.height * .06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: ColorsRes.darkBackground,
        ),
      ),
    );
  }
}
