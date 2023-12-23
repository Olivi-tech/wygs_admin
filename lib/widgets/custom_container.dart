import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;
  final Color? color;
  final String? image;
  final BoxDecoration? decoration;
  final Border? border;
 
  

  const CustomContainer({
    super.key,
    this.height,
    this.width,
    this.child,
    this.color,
    this.decoration,
    this.border,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: decoration,
      color: color,
      child: child,
    );
  }
}
