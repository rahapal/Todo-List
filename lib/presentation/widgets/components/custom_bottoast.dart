import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/presentation/presentation.dart';

class CustomBotToast {
  static showLoading() {
    BotToast.showLoading();
  }

  static text(
    String text, {
    bool isSuccess = true,
    Duration duration = const Duration(seconds: 2),
  }) {
    return BotToast.showText(
      text: text,
      duration: duration,
      textStyle: const TextStyle(
        color: Colors.white,
      ),
      contentColor: isSuccess ? Colors.green.shade600 : Colors.red,
    );
  }

  static showErrorDialog({
    required String title,
    required String message,
    VoidCallback? onCancel,
  }) {
    BotToast.showWidget(
      toastBuilder: (cancelFunc) => Material(
        color: Colors.black45,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 23),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 18,
                ),
                CustomButton(
                  title: "Okay",
                  textStyle:
                      const TextStyle(color: AppColors.white, fontSize: 14),
                  onPressed: () {
                    onCancel?.call();
                    BotToast.cleanAll();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
