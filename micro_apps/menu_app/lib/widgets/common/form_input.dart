import 'package:flutter/material.dart';

import 'package:menu_app/themes/colors.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.text,
    this.obscureText = false,
    this.readOnly,
    this.keyboardType,
    this.onSaved,
    this.borderColor,
    this.validator,
    this.controller,
    this.onChanged,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.hintText,
    this.enabled,
  });

  final String text;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool? readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? borderColor;
  final void Function()? onTap;
  final String? initialValue;
  final String? hintText;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      onTap: onTap,
      onSaved: onSaved,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(
            color: borderColor != null ? borderColor! : ThemeColors.authPrimary,
          ),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: suffixIcon,
        ),
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
        labelStyle: Theme.of(context).textTheme.displaySmall,
        hintText: hintText,
      ),
      validator: validator,
      controller: controller,
      readOnly: readOnly ?? false,
      enabled: enabled ?? true,
    );
  }
}
