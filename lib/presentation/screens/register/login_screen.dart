import 'package:flutter/material.dart';
import 'package:todo_list/presentation/presentation.dart';
import 'package:todo_list/presentation/widgets/components/custom_button.dart';
import 'package:todo_list/presentation/widgets/components/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBarWidget(
          title: Text("Login"),
          titleStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          automaticallyImplyLeading: false,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Login with your Email",
                style: kTextStyleheadline,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.containerBgcolor,
                    borderRadius: BorderRadius.circular(21),
                    border: Border.all(
                        color: AppColors.textFieldBorderColor, width: 1),
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        hintText: "Enter your Email",
                        headerText: "Email",
                        fillColor: AppColors.white,
                        filled: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 30),
                        child: CustomTextField(
                          hintText: "Enter your password",
                          controller: _passwordController,
                          headerText: "Password",
                          fillColor: AppColors.white,
                          filled: true,
                        ),
                      ),
                      CustomButton(
                        onPressed: () {},
                        title: "Login",
                        textStyle: const TextStyle(
                            color: AppColors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
