import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final double? elevation;
  final Widget? title;
  final String? titleText;
  final TextStyle? titleStyle;
  final Widget? flexibleSpace;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final VoidCallback? onPressed;
  final Color? shadowColor;

  const CustomAppBarWidget({
    super.key,
    this.elevation = 0.0,
    this.title,
    this.flexibleSpace,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.titleText,
    this.onPressed,
    this.titleStyle,
    this.shadowColor,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      elevation: elevation,
      shadowColor: shadowColor ?? Colors.grey.withOpacity(0.12),
      title: title ??
          Text(
            titleText ?? "",
            style: titleStyle,
          ),
      actions: actions,
      centerTitle: true,
      automaticallyImplyLeading: automaticallyImplyLeading,
      flexibleSpace: flexibleSpace,
      leading: automaticallyImplyLeading
          ? leading ??
              BackButton(
                color: Theme.of(context).colorScheme.secondary,
                onPressed: onPressed,
              )
          : const SizedBox(),
    );
  }
}
