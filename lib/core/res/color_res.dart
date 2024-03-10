import 'dart:math';
import 'dart:ui';

class ColorsRes {
  const ColorsRes._();

  static const Color darkBackground = Color(0xFF2a2b2e);
  static const Color light = Color(0xFFFFFFFF);

  static const colors = [
    Color(0xffd80000),
    Color(0xFF027EB5),
    Color(0xFFF50FCF),
    Color(0xFFAC0FF5),
    Color(0xFF0AA31E),
    Color(0xFFF9F900),
  ];

  static Color randomColor() {
    final random = Random();
    int randomIndex = random.nextInt(ColorsRes.colors.length);
    return ColorsRes.colors[randomIndex];
  }
}
