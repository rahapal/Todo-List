import 'package:flutter/material.dart';
import 'package:todo_list/presentation/presentation.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final TextEditingController? controller;
  final bool? enableInteractiveSelection;
  final String? hintText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function(String)? onFormSubmitted;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final bool? enabled;
  final bool autofocus;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final int? maxLength;
  final bool? filled;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final TextStyle? errorStyle;
  final TextCapitalization textCapitalization;
  final Widget? label;
  final AutovalidateMode? autovalidateMode;
  final bool? showCursor;
  final bool readOnly;
  final String? headerText;
  final String obscuringCharacter;

  const CustomTextField({
    super.key,
    this.textEditingController,
    this.enableInteractiveSelection,
    this.controller,
    this.hintText,
    this.textInputType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.maxLines = 1,
    this.prefixIcon,
    this.enabled = true,
    this.autofocus = false,
    this.onTap,
    this.contentPadding,
    this.enabledBorder,
    this.disabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.onFormSubmitted,
    this.textInputAction,
    this.maxLength,
    this.filled = false,
    this.fillColor,
    this.hintStyle,
    this.style,
    this.textCapitalization = TextCapitalization.none,
    this.errorStyle,
    this.label,
    this.autovalidateMode,
    this.showCursor,
    this.headerText,
    this.obscuringCharacter = '*',
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerText == null || headerText == ""
            ? const SizedBox.shrink()
            : Text(
                headerText!,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
        headerText == null || headerText == ""
            ? const SizedBox()
            : const SizedBox(
                height: 8,
              ),
        TextFormField(
          enableInteractiveSelection: enableInteractiveSelection,
          showCursor: showCursor,
          readOnly: readOnly,
          enabled: enabled,
          autovalidateMode: autovalidateMode,
          maxLength: maxLength,
          obscureText: obscureText,
          obscuringCharacter: obscuringCharacter,
          controller: textEditingController ?? controller,
          autofocus: autofocus,
          autocorrect: false,
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!(value);
            }
          },
          validator: (String? input) {
            if (validator != null) {
              validator!(input);
            }
            return null;
          },
          enableSuggestions: false,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          onTap: onTap,
          onFieldSubmitted: onFormSubmitted,
          textCapitalization: textCapitalization,
          style: style ??
              Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.green, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            label: label,
            fillColor: fillColor,
            filled: filled,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hintText,
            errorStyle: errorStyle,
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.5)),
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: AppColors.textFieldBorderColor, width: 1),
                ),
            disabledBorder: disabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                      color: AppColors.textFieldBorderColor, width: 1),
                ),
            errorBorder: errorBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error, width: 1)),
            errorMaxLines: 2,
            focusedErrorBorder: focusedErrorBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                        width: 1.5)),
            hintStyle: hintStyle ??
                TextStyle(fontSize: 16, color: AppColors.greyShadow),
          ),
        ),
      ],
    );
  }
}
