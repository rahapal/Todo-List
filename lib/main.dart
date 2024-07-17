import 'package:flutter/material.dart';
import 'package:todo_list/presentation/constants/app_colors.dart';
import 'package:todo_list/presentation/screens/login/login_screen.dart';
import 'package:todo_list/presentation/screens/register/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: ThemeClass.lightTheme,
      home: const LoginScreen(),
    );
  }
}
