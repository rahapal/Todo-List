import 'dart:async';
import 'dart:developer';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_list/bloc/auth_bloc/auth.dart';
import 'package:todo_list/bloc/auth_bloc/auth_cubit.dart';
import 'package:todo_list/presentation/presentation.dart';
import 'package:todo_list/presentation/screens/home/home_screen.dart';

class OtpArgs {
  final String? verificationId;
  final String? completeNumber;
  final int? resendToken;

  OtpArgs({
    this.verificationId,
    this.completeNumber,
    this.resendToken,
  });
}

class OTPScreen extends StatefulWidget {
  final OtpArgs args;

  const OTPScreen({super.key, required this.args});

  static const String routeName = "/otpscreen";
  static GoRoute route() {
    return GoRoute(
      path: routeName,
      builder: (_, state) => OTPScreen(args: state.extra as OtpArgs),
    );
  }

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _optNumber = TextEditingController();
  bool isLoading = false;
  int? resendToken;
  late Timer pageTimer;

  int seconds = 60;

  @override
  void initState() {
    super.initState();
    resendToken = widget.args.resendToken;
    initTimer();
  }

  @override
  void dispose() {
    pageTimer.cancel();
    super.dispose();
  }

  restartTimer() {
    seconds = 60;
    pageTimer.cancel();
    initTimer();
  }

  void initTimer() {
    pageTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      log("\x1B[32m ${timer.tick} \x1B[0m");

      seconds -= 1;
      if (mounted) {
        setState(() {});
      }
      if (seconds <= 0) {
        seconds = 0;
        pageTimer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: const CustomAppBarWidget(),
        body: BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
          if (state is AuthLoggedInState) {
            context.go(HomeScreen.routeName);
          } else if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.error),
              duration: const Duration(milliseconds: 2000),
            ));
          }
        }, builder: (context, state) {
          if (state is AuthLoadingState) {
            BotToast.showLoading();
          } else {
            BotToast.closeAllLoading();
          }

          return Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 25, right: 25),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Enter the 6-digit code',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Text(
                  'We have sent you a code on ${widget.args.completeNumber}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: Pinput(
                    length: 6,
                    controller: _optNumber,
                    defaultPinTheme: PinTheme(
                      height: 62,
                      width: 70,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(2),
                        ),
                        border: Border.all(color: AppColors.grey),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    submittedPinTheme: PinTheme(
                      height: 62,
                      width: 70,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2)),
                        border: Border.all(color: AppColors.green),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Didn\'t get a code?',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                        onTap: seconds <= 0
                            ? () async {
                                restartTimer();

                                // await FirebaseAuth.instance
                                //     .verifyPhoneNumber(
                                //   forceResendingToken: resendToken,
                                //   phoneNumber: widget.args.completeNumber,
                                //   verificationCompleted:
                                //       (PhoneAuthCredential credential) async {},
                                //   verificationFailed:
                                //       (FirebaseAuthException e) async {
                                //     print("$e");
                                //   },
                                //   codeSent:
                                //       (String verificationId, int? resendToken) {
                                //     resendToken = resendToken;
                                //   },
                                //   codeAutoRetrievalTimeout:
                                //       (String verificationId) async {},
                                // )
                                //     .onError((error, stackTrace) {
                                //   print(
                                //       "Error during phone verification: $error");

                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     const SnackBar(
                                //       content: Text(
                                //           'An error occurred during phone verification.'),
                                //     ),
                                //   );
                                // });
                              }
                            : null,
                        child: Text(
                          seconds <= 0 ? 'Resend Now' : "00:$seconds",
                          style: const TextStyle(
                              color: AppColors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                onPressed: () async {
                  if (_optNumber.text.isEmpty) {
                    CustomBotToast.showErrorDialog(
                      title: "Message",
                      message: 'Please enter OTP code',
                    );
                    BotToast.closeAllLoading();
                  } else {
                    BlocProvider.of<AuthCubit>(context)
                        .verifyOTP(_optNumber.text);
                  }
                },
                mainAxisAlignment: MainAxisAlignment.center,
                title: "Confirm",
              ),
            ]),
          );
        }),
      ),
    );
  }
}
