import 'package:flutter/painting.dart';

class KeyboardStyle {
  final Color backgroundColor;
  final Color keyColor;
  final TextStyle keyTextStyle;
  final BoxShadow shadow;
  final BoxBorder keyBorder;
  final BorderRadius borderRadius;
  final EdgeInsets keyPadding;

  KeyboardStyle({
    this.backgroundColor = const Color(0xFFF8F8F8),
    this.keyColor = const Color(0xFFFFFFFF),
    this.shadow = const BoxShadow(
      color: Color(0x33000000),
      spreadRadius: 0,
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
    this.keyBorder = const Border.fromBorderSide(BorderSide.none),
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.keyPadding = const EdgeInsets.all(8),
    this.keyTextStyle = const TextStyle(
      color: Color(0xFF000000),
      fontSize: 20,
      decoration: TextDecoration.none
    ),
  });


}