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
    this.fillColor,
    this.borderWidth,
    this.hasShadow = false, // Add this line for conditional shadow
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
  final Color? fillColor;
  final double? borderWidth;
  final bool hasShadow; // Add this line for conditional shadow

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: hasShadow
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ThemeColors.black.withOpacity(0.1),
                  blurRadius: 9,
                  offset: const Offset(1, 2.5),
                  spreadRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.circular(50.0),
            )
          : null, // No shadow if hasShadow is false
      child: TextFormField(
        keyboardType: keyboardType,
        initialValue: initialValue,
        obscureText: obscureText ?? false,
        onTap: onTap,
        onSaved: onSaved,
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: fillColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: borderColor ?? ThemeColors.authPrimary,
              width: borderWidth ?? 1,
            ),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: suffixIcon,
          ),
          label: text.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 14.0),
                  ),
                )
              : null, // Conditionally display the label if text is not null
          labelStyle: Theme.of(context).textTheme.displaySmall,
          hintText: hintText,
          errorStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ThemeColors.primary),
        ),
        validator: validator,
        controller: controller,
        readOnly: readOnly ?? false,
        enabled: enabled ?? true,
      ),
    );
  }
}
