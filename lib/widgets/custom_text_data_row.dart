import 'package:flutter/material.dart';
import 'package:guitar_songs/constants/constants.dart';

class CustomTextDataRow extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final int? maxLine;
  const CustomTextDataRow({
    super.key,
    required this.text,
    this.size,
    this.color,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      style: TextStyle(
        fontSize: AppSize.xsmall,
        color: AppColor.indigo.withOpacity(0.9),
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
