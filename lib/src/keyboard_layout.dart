import 'package:embedded_keyboard/src/special_key.dart';

class KeyboardLayout {
  String name;
  List<List<dynamic>> defaultLayout;
  late List<List<dynamic>> shiftedLayout;
  late List<List<dynamic>> symbolLayout;
  late List<List<dynamic>> shiftedSymbolLayout;

  KeyboardLayout({
      required this.name,
      required this.defaultLayout,
      shiftedLayout,
      symbolLayout,
      shiftedSymbolLayout,

  }) {
    this.shiftedLayout = shiftedLayout ?? defaultLayout;
    this.symbolLayout = symbolLayout ?? defaultLayout;
    this.shiftedSymbolLayout = shiftedSymbolLayout ?? symbolLayout ?? defaultLayout;
  }

}