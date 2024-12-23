import 'package:flutter/widgets.dart';

class SpecialKey {
  final String name;
  final String? input;
  final Widget icon;
  final int extent;
  final bool allowRepeat;
  final Color? overrideColor;

  const SpecialKey({
    required this.name,
    required this.icon,
    this.extent = 1,
    this.allowRepeat = false,
    this.input,
    this.overrideColor
  });

  SpecialKey copyWith({
    String? name,
    String? input,
    Widget? icon,
    int? extent,
    bool? allowRepeat,
    Color? overrideColor,
  }) {
    return SpecialKey(
      name: name ?? this.name,
      input: input ?? this.input,
      icon: icon ?? this.icon,
      extent: extent ?? this.extent,
      allowRepeat: allowRepeat ?? this.allowRepeat,
      overrideColor: overrideColor ?? this.overrideColor,
    );
  }
}