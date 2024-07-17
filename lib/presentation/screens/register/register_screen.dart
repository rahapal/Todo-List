import 'package:flutter/material.dart';
import 'package:todo_list/presentation/presentation.dart';
import 'package:todo_list/presentation/widgets/components/custom_button.dart';
import 'package:todo_list/presentation/widgets/components/custom_textfield.dart';

class RegisterScren extends StatefulWidget {
  const RegisterScren({super.key});

  @override
  State<RegisterScren> createState() => _RegisterScrenState();
}

class _RegisterScrenState extends State<RegisterScren> {
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
          title: Text("Register"),
          titleStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          automaticallyImplyLeading: false,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Create an Account",
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
                        padding: const EdgeInsets.only(top: 15, bottom: 5),
                        child: CustomTextField(
                          hintText: "Enter your password",
                          controller: _passwordController,
                          headerText: "Password",
                          fillColor: AppColors.white,
                          filled: true,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            "Have an account?",
                            style: kTextStyledefault,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Login",
                                style: kTextstylemedium,
                              ))
                        ],
                      ),
                      CustomButton(
                        onPressed: () {},
                        title: "Register",
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
