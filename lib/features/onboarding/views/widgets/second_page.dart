import 'package:flutter/material.dart';
import 'package:todo_riverpod/core/common/widgets/round_button.dart';
import 'package:todo_riverpod/core/common/widgets/white_space.dart';
import 'package:todo_riverpod/core/res/image_res.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageRes.todo),
          const WhiteSpace(height: 50),
          RoundButton(
            text: 'Login with phone',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
