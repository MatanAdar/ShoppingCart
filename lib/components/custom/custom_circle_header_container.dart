import 'package:flutter/material.dart';

class CirclueHeaderContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child;
  final Color backgroundColor;

  const CirclueHeaderContainer({
    super.key,
    this.child,
    this.width = 200,
    this.height = 200,
    this.radius = 200,
    this.padding = 0,
    this.backgroundColor = Colors.white54,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
