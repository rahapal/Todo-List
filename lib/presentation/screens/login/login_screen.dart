import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_list/bloc/auth_bloc/auth.dart';
import 'package:todo_list/presentation/presentation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "/loginscreen";
  static GoRoute route() {
    return GoRoute(
      path: routeName,
      builder: (_, state) => const LoginScreen(),
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String phoneCC = "+977";

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const CustomAppBarWidget(
          titleText: "Login",
          automaticallyImplyLeading: false,
        ),
        body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          if (state is AuthLoadingState) {
            BotToast.showLoading();
          }
          if (state is AuthErrorState) {
            BotToast.closeAllLoading();
            BotToast.showText(text: state.error);
          }
          if (state is AuthCodeSentState) {
            BotToast.closeAllLoading();
            context.push(OTPScreen.routeName,
                extra: OtpArgs(
                  completeNumber: phoneCC + _numberController.text,
                  verificationId: state.verifiactionId,
                  resendToken: state.forceResendingToken,
                ));
          }
        }, builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                Column(
                  children: [
                    const Text(
                      "Login with Phone Number",
                      style: kTextStyleheadline,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.containerBgcolor,
                          borderRadius: BorderRadius.circular(21),
                          border: Border.all(
                              color: AppColors.textFieldBorderColor, width: 1),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                textInputType: TextInputType.phone,
                                hintText: "Enter you Phone Number",
                                headerText: "Phone Number",
                                controller: _numberController,
                                fillColor: AppColors.white,
                                filled: true,
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12.0,
                                        right: 8,
                                      ),
                                      child: SvgPicture.asset(
                                        AssetsSource.nepalFlag,
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    Text(phoneCC),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 10),
                                child: CustomButton(
                                  onPressed: () async {
                                    String phoneNumber =
                                        "$phoneCC${_numberController.text}";
                                    BlocProvider.of<AuthCubit>(context)
                                        .sendOTP(phoneNumber);
                                  },
                                  title: "Login",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
