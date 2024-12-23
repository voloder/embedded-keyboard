import 'package:embedded_keyboard/src/special_key.dart';
import 'package:flutter/material.dart';

class SpecialKeySets {
  static final defaultSpecialKeySet = {
    "shift": const SpecialKey(
        name: "shift", icon: Icon(Icons.arrow_upward), extent: 2),
    "backspace": const SpecialKey(
        name: "backspace",
        icon: Icon(Icons.backspace),
        extent: 2,
        allowRepeat: true),
    "enter": const SpecialKey(
        name: "enter", icon: Icon(Icons.keyboard_return), extent: 2),
    "space": const SpecialKey(
        name: "space", icon: Icon(Icons.space_bar), extent: 5, input: " "),
    "symbol": const SpecialKey(name: "symbol", icon: Icon(Icons.keyboard)),
  };

  static final numpadSpecialKeySet = {
    "shift": const SpecialKey(
        name: "shift", icon: Icon(Icons.arrow_upward), extent: 1),
    "backspace": const SpecialKey(
        name: "backspace",
        icon: Icon(Icons.backspace),
        extent: 1,
        allowRepeat: true),
    "enter": const SpecialKey(
        name: "enter", icon: Icon(Icons.keyboard_return), extent: 1),
    "space": const SpecialKey(
        name: "space", icon: Icon(Icons.space_bar), extent: 1, input: " "),
    "symbol": const SpecialKey(name: "symbol", icon: Icon(Icons.keyboard)),
  };
}
