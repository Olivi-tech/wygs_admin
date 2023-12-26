import 'package:flutter/material.dart';
import 'package:guitar_songs/constants/constants.dart';

class CustomTextDataColumn extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  const CustomTextDataColumn({
    super.key,
    required this.text,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: AppSize.small,
        color: AppColor.indigo,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
