import 'package:flutter/material.dart';
import 'package:guitar_songs/constants/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String hintText;
  final void Function(String)? onChanged;
  final TextInputType? keyBoardType;
  final Color cursorColor;
  final Color fillColor;
  final TextStyle? hintStyle;
  final TextStyle? suffixStyle;
  const CustomTextFormField(
      {super.key,
      this.controller,
      required this.hintText,
      this.onChanged,
      this.keyBoardType,
      this.prefixIcon,
      required this.fillColor,
      this.hintStyle,
      this.suffixStyle,
      required this.cursorColor});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Color(0xE5D1D9E6),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Color(0xE5D1D9E6),
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Color(0xE5D1D9E6),
              )),
          hintStyle: const TextStyle(
            fontSize: AppSize.meddium,
            fontWeight: FontWeight.w500,
          ),
          suffixStyle: suffixStyle,
          filled: true,
          fillColor: fillColor),
      keyboardType: keyBoardType,
    );
  }
}
