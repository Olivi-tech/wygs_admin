import 'package:flutter/material.dart';
import 'package:guitar_songs/constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String? hintText;
  final void Function(String)? onChanged;
  final FormFieldValidator? validator;
  final TextInputType? keyBoardType;
  final Color fillColor;
  final Color borderColor;
  final TextStyle? hintStyle;
  final bool readOnly;
  final TextStyle? suffixStyle;
  final bool isVisibleText;
  final String obscuringCharacter;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.keyBoardType,
    this.suffixIcon,
    required this.fillColor,
    this.hintStyle,
    this.suffixStyle,
    this.validator,
    this.isVisibleText = false,
    this.readOnly = false,
    required this.borderColor,
    this.obscuringCharacter = '●',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      obscuringCharacter: obscuringCharacter,
      cursorColor: AppColor.blue,
      obscureText: isVisibleText,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          focusColor: AppColor.lightSilver,
          contentPadding: const EdgeInsets.only(top: 10, left: 10),
          hintText: hintText,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: borderColor,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: borderColor,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: borderColor,
              )),
          hintStyle: const TextStyle(
            fontSize: AppSize.large,
            fontWeight: FontWeight.w500,
          ),
          suffixStyle: suffixStyle,
          filled: true,
          fillColor: fillColor),
      keyboardType: keyBoardType,
    );
  }
}
