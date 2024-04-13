import 'package:embedded_keyboard/embedded_keyboard.dart';

class KeyboardLayouts {
  static final defaultLayout = KeyboardLayout(name: "default", defaultLayout: [
    ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
    ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
    ["symbol", "z", "x", "c", "v", "b", "n", "m", "backspace"],
    ["shift", "space", "enter"]
  ], shiftedLayout: [
    ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
    ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
    ["symbol", "Z", "X", "C", "V", "B", "N", "M", "backspace"],
    ["shift", "space", "enter"]
  ], symbolLayout: [
    ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
    ["@", "#", "%", "&", "*", "(", ")", "-", "+"],
    ["symbol", ".", ",", "?", "!", "'", "\"", ":", ";", "backspace"],
    ["shift", "space", "enter"],
  ], shiftedSymbolLayout: [
    ["!", "@", "#", "\$", "%", "^", "&", "*", "(", ")"],
    ["_", "+", "{", "}", "[", "]", "<", ">", "=", "/"],
    ["symbol", ".", ",", "?", "!", "'", "\"", ":", ";", "backspace"],
    ["shift", "space", "enter"],
  ]);
}