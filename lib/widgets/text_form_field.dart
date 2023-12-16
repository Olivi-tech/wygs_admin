import 'package:flutter/material.dart';
import 'package:guitar_songs/constants/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String? hintText;
  final void Function(String)? onChanged;
  final FormFieldValidator? validator;
  final TextInputType? keyBoardType;
  final Color fillColor;
  final TextStyle? hintStyle;
  final TextStyle? suffixStyle;
  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.keyBoardType,
    this.prefixIcon,
    required this.fillColor,
    this.hintStyle,
    this.suffixStyle,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColor.blue,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          focusColor: AppColor.lightSilver,
          contentPadding: const EdgeInsets.only(top: 10, left: 10),
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
