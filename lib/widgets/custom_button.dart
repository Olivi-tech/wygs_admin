import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? textSize;
  final Color? backgroundColor;
  final Color borderColor;
  final Color? textColor;
  final double fixedHeight;
  final double fixedWidth;
  final FontWeight? weight;
  final bool isLoading;
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textSize,
    this.backgroundColor,
    this.textColor,
    this.borderColor = Colors.transparent,
    this.fixedHeight = 0,
    this.fixedWidth = 0,
    this.isLoading = false,
    this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(fixedWidth, fixedHeight),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: borderColor)),
        backgroundColor: backgroundColor,
      ),
      onPressed: onPressed,
      child: isLoading
          ? const CupertinoActivityIndicator()
          : Text(
              text,
              style: TextStyle(
                fontSize: textSize,
                color: textColor,
                fontWeight: weight,
              ),
            ),
    );
  }
}
