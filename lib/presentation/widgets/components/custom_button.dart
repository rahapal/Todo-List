import 'package:flutter/material.dart';
import 'package:todo_list/presentation/presentation.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double? buttonWidth;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final MainAxisAlignment mainAxisAlignment;
  final BorderSide side;
  const CustomButton(
      {super.key,
      required this.title,
      this.buttonWidth,
      this.icon,
      this.backgroundColor,
      this.foregroundColor,
      this.onPressed,
      this.textStyle,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.side = BorderSide.none});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.green,
        foregroundColor: foregroundColor ?? Theme.of(context).iconTheme.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: side,
        ),
        disabledBackgroundColor: AppColors.fadedGreen,
      ),
      onPressed: onPressed,
      child: SizedBox(
        height: 42,
        width: buttonWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Text(
              title,
              style: textStyle ??
                  const TextStyle(
                      color: AppColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
