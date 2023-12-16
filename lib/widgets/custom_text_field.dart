import 'package:flutter/material.dart';
import 'package:guitar_songs/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String hintText;
  final void Function(String)? onChanged;
  final TextInputType? keyBoardType;
  final Color fillColor;
  final FormFieldValidator? validator;
  final TextStyle? hintStyle;
  final TextStyle? suffixStyle;
  final bool isVisibleText;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.onChanged,
    this.validator,
    this.keyBoardType,
    this.prefixIcon,
    required this.fillColor,
    this.hintStyle,
    this.suffixStyle,
    this.isVisibleText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isVisibleText,
      cursorColor: AppColor.blue,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColor.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColor.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColor.white)),
          hintStyle: const TextStyle(fontSize: AppSize.xmeddium),
          suffixStyle: suffixStyle,
          filled: true,
          fillColor: fillColor),
      keyboardType: keyBoardType,
    );
  }
}
