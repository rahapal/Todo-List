import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/presentation/presentation.dart';
import 'package:todo_list/presentation/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = "/splashscreen";
  static GoRoute route() {
    return GoRoute(
      path: routeName,
      builder: (_, state) => const SplashScreen(),
    );
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    Future(() async {
      await Future.delayed(const Duration(seconds: 2));
      String page = LoginScreen.routeName;
      dynamic args;

      final userId = FirebaseAuth.instance.currentUser?.uid;

      log("\x1B[32m sushant   $userId \x1B[0m");

      //final phoneCC = FirebaseAuth.instance.currentUser.

      if (userId != null) {
        page = HomeScreen.routeName;
      } else {
        FirebaseAuth.instance.signOut();
        page = LoginScreen.routeName;
      }

      return (page, args);
    }).then((value) {
      context.go(value.$1, extra: value.$2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Expanded(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsSource.mainLogo,
                height: 150,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "TODO APP",
                style: TextStyle(fontSize: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
