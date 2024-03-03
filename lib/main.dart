import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/core/res/color_res.dart';
import 'package:todo_riverpod/features/authentication/app/user_provider.dart';
import 'package:todo_riverpod/features/onboarding/views/onboarding_screen.dart';
import 'package:todo_riverpod/features/todo/views/home_screen.dart';
import 'package:todo_riverpod/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(430.0, 932.0),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          title: 'Todo',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
            scaffoldBackgroundColor: ColorsRes.darkBackground,
            useMaterial3: true,
          ),
          home: ref.watch(userProvider).when(
                data: (userExists) {
                  if (userExists) return const HomeScreen();
                  return const OnBoardingScreen();
                },
                error: (error, stackTrace) {
                  debugPrint('Error: $error');
                  debugPrint(stackTrace.toString());
                  return const OnBoardingScreen();
                },
                loading: () => const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
        );
      },
    );
  }
}
