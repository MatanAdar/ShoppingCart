import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomWishlistIcon extends StatelessWidget {
  final double top;
  final double right;
  final bool isWishListed;
  void Function()? onPressed;

  CustomWishlistIcon({
    super.key,
    this.top = 0,
    this.right = 0,
    required this.isWishListed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      child: Opacity(
        opacity: 0.8,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              isWishListed ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: isWishListed ? Colors.red : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
