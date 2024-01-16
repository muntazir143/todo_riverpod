import 'package:flutter/material.dart';
import 'package:todo_riverpod/core/common/widgets/fading_text.dart';
import 'package:todo_riverpod/core/common/widgets/white_space.dart';
import 'package:todo_riverpod/core/res/image_res.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
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
              Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        iconSize: 30,
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                      const FadingText(
                        'Skip',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
