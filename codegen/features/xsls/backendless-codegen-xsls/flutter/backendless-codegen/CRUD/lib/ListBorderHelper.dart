import 'package:flutter/material.dart';

class ListBorderHelper {
  
  static Border borderForIndex(int index, {int of}) {
    final isLast = index == of - 1;

    final defaultBorderSize = BorderSide(
      color: Colors.black,
      width: 0.5
    );
    
    if (isLast) {
      return Border(
        top: defaultBorderSize,
        bottom: defaultBorderSize
      );
    } else {
      return Border(
        top: defaultBorderSize,
      );
    }
  }

  static Border allGreyBorders() {
    final defaultBorderSize = BorderSide(
      color: Colors.grey,
      width: 0.5
    );

    return Border(
      top: defaultBorderSize,
      bottom: defaultBorderSize,
      left: defaultBorderSize,
      right: defaultBorderSize
    );
  }
}