import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_riverpod/core/res/color_res.dart';
import 'package:todo_riverpod/features/onboarding/views/onboarding_screen.dart';
import 'package:todo_riverpod/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430.0, 932.0),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
            scaffoldBackgroundColor: ColorsRes.darkBackground,
            useMaterial3: true,
          ),
          home: const OnBoardingScreen(),
        );
      },
    );
  }
}
