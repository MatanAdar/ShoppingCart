import 'package:flutter/material.dart';

class CustomImage {
  static Widget getImage(String path, {double height = 180}) {
    return path.startsWith('http') || path.startsWith('https')
        ? Image.network(
            path,
            height: height,
          )
        : Image.asset(
            path,
            height: height,
          );
  }
}
