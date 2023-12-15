import 'package:flutter/material.dart';
import 'package:guitar_songs/constants/constants.dart';
import 'package:guitar_songs/widgets/widgets.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? textSize;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: Size(width * 0.9, height * 0.07),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: AppColor.blue),
        onPressed: onPressed,
        child: FittedBox(
          child: CustomText(
            text: text,
            size: textSize,
            color: AppColor.white,
          ),
        ));
  }
}
