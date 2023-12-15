import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final TextOverflow? textOverflow;
  final int? maxLine;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? height;
  final double? letterSpacing;
  const CustomText(
      {super.key,
      required this.text,
      this.size,
      this.color,
      this.textOverflow,
      this.maxLine,
      this.textAlign,
      this.fontWeight,
      this.height,
      this.letterSpacing});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          color: color,
          overflow: textOverflow,
          fontWeight: fontWeight,
          height: height),
    );
  }
}
