import 'package:flutter/material.dart';

import 'package:location_app/themes/colors.dart';
import 'package:location_app/themes/fonts.dart';

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
    this.hasShadow = false,
    this.hasOfferTag = false, // Property to control offer tag
    this.offer = '10',
    this.isDescription = false,
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
  final bool hasShadow;
  final bool hasOfferTag; // Property to control offer tag
  final String offer;
  final bool isDescription;

  @override
  Widget build(BuildContext context) {
    final double contentPadding = hasOfferTag ? 0 : 15;
    return Container(
      height: isDescription ? 200 : null,
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
          : null,
      child: TextFormField(
        expands: isDescription ? true : false,
        minLines: isDescription ? null : 1,
        maxLines: isDescription ? null : 1,
        textAlignVertical: TextAlignVertical.top,
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
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: borderColor ??
                  ThemeColors
                      .authPrimary, // Maintain the same color as enabledBorder
              width: borderWidth ?? 1, // Keep the same border width
            ),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: hasOfferTag
              ? Container(
                  decoration: BoxDecoration(
                    color: ThemeColors.authPrimary,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                    ),
                  ),
                  alignment: Alignment.center,
                  width: 70,
                  child: Text(
                    '$offer% off',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: suffixIcon,
                ),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.titleSmallTitleBrown,
          label: hasOfferTag
              ? null
              : text.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    )
                  : null,
          contentPadding:
              EdgeInsets.symmetric(vertical: contentPadding, horizontal: 10.0),
        ),
        validator: validator,
        controller: controller,
        readOnly: readOnly ?? false,
        enabled: enabled ?? true,
      ),
    );
  }
}
