import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/presentation/presentation.dart';
import 'package:todo_list/presentation/screens/home/home_screen.dart';
import 'package:todo_list/presentation/screens/otp_screen/otp_screen.dart';
import 'package:todo_list/presentation/screens/splash/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyRouter {
  static final router = GoRouter(
    navigatorKey: navigatorKey,
    observers: [BotToastNavigatorObserver()],
    initialLocation: SplashScreen.routeName,
    routes: [
      LoginScreen.route(),
      OTPScreen.route(),
      HomeScreen.route(),
      SplashScreen.route(),
    ],
  );
}
