import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/presentation/presentation.dart';

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
