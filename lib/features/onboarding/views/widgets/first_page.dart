import 'package:flutter/material.dart';
import 'package:todo_riverpod/core/common/widgets/fading_text.dart';
import 'package:todo_riverpod/core/common/widgets/white_space.dart';
import 'package:todo_riverpod/core/res/image_res.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageRes.todo),
          const WhiteSpace(height: 50),
          const FadingText(
            'ToDo Tasks',
            textAlign: TextAlign.center,
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
