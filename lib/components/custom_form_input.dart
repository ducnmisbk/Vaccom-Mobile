import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vaccom_mobile/commons/color.dart';

class CustomFormInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final FocusNode focusNode;
  final List<TextInputFormatter> inputFormatters;
  final Widget suffixIcon;
  final Function validator;
  final bool enabled;
  final int maxLines;
  final bool required;
  final TextCapitalization textCapitalization;
  final Function onChanged;
  CustomFormInput({
    this.controller,
    this.labelText = '',
    this.keyboardType,
    this.focusNode,
    this.obscureText = false,
    this.inputFormatters,
    this.validator,
    this.suffixIcon,
    this.enabled = true,
    this.required = false,
    this.onChanged,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: textCapitalization,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColor.deactive,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColor.deactive,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColor.link,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColor.error,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColor.error,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColor.deactive,
          ),
        ),
        labelText: labelText + (required ? " *" : ""),
        hintText: labelText,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: enabled ? Colors.white : AppColor.deactive,
      ),
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 14,
        color: AppColor.nearlyBlack,
      ),
      enabled: enabled,
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      obscureText: obscureText,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      validator: validator,
    );
  }
}
