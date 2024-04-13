import 'dart:async';

import 'package:embedded_keyboard/src/keyboard_layout.dart';
import 'package:embedded_keyboard/src/keyboard_style.dart';
import 'package:embedded_keyboard/src/special.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum KeyboardMode {
  normal, // Normal keyboard
  shift, // Shifted keyboard
  symbol, // Symbol keyboard
  shiftSymbol, // Shifted symbol keyboard
}

class Keyboard extends StatefulWidget {
  final KeyboardMode mode;
  final FocusNode? focusNode;
  final TextEditingController? textController;
  final void Function(String)? onKeyPressed;
  final void Function(SpecialKey)? onSpecialKeyPressed;
  final KeyboardLayout layout;
  final KeyboardStyle? style;
  final Map<String, SpecialKey> specialKeys;

  const Keyboard({
    Key? key,
    required this.mode,
    required this.layout,
    required this.specialKeys,
    this.onKeyPressed,
    this.onSpecialKeyPressed,
    this.focusNode,
    this.textController,
    this.style,
  }) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  late KeyboardStyle style = widget.style ?? KeyboardStyle();

  Timer? _repeatTimer;

  @override
  Widget build(BuildContext context) {
    List<List<dynamic>> keys;
    switch (widget.mode) {
      case KeyboardMode.normal:
        keys = widget.layout.defaultLayout;
        break;
      case KeyboardMode.shift:
        keys = widget.layout.shiftedLayout;
        break;
      case KeyboardMode.symbol:
        keys = widget.layout.symbolLayout;
        break;
      case KeyboardMode.shiftSymbol:
        keys = widget.layout.shiftedSymbolLayout;
        break;
    }
    return Container(
      color: style.backgroundColor,
      child: Column(
        children: [
          for (final row in keys)
            Expanded(
              child: Row(
                children: row.map((e) {
                  if (widget.specialKeys.containsKey(e)) {
                    final key = widget.specialKeys[e]!;
                    return Expanded(
                      flex: widget.specialKeys[e]!.extent,
                      child: GestureDetector(
                          onLongPress: () {
                            if (key.allowRepeat) {
                              _repeatTimer = Timer.periodic(
                                  const Duration(milliseconds: 50), (timer) {
                                widget.onSpecialKeyPressed?.call(key);
                                if (key.input != null) {
                                  widget.textController?.text += key.input!;
                                }
                                if (!(widget.focusNode?.hasFocus ?? false)) {
                                  widget.focusNode?.requestFocus();
                                }
                              });
                            }
                          },
                          onLongPressEnd: (details) {
                            _repeatTimer?.cancel();
                          },
                          onTap: () {
                            widget.onSpecialKeyPressed?.call(key);
                            if (key.input != null) {
                              widget.textController?.text += key.input!;
                            }
                            if (!(widget.focusNode?.hasFocus ?? false)) {
                              widget.focusNode?.requestFocus();
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(style.keyPadding),
                            child: Container(
                              decoration: BoxDecoration(
                                border: style.keyBorder,
                                borderRadius:
                                    BorderRadius.circular(style.borderRadius),
                                color: key.overrideColor ?? style.keyColor,
                                boxShadow: [
                                  style.shadow,
                                ],
                              ),
                              child: Center(
                                  child: widget.specialKeys[e]!.icon),
                            ),
                          )),
                    );
                  } else {
                    return Expanded(
                      child: GestureDetector(
                          onTap: () {
                            widget.onKeyPressed?.call(e);
                            widget.textController?.text += e;
                            if (!(widget.focusNode?.hasFocus ?? false)) {
                              widget.focusNode?.requestFocus();
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(style.keyPadding),
                            child: Container(
                              decoration: BoxDecoration(
                                border: style.keyBorder,
                                color: style.keyColor,
                                borderRadius:
                                    BorderRadius.circular(style.borderRadius),
                                boxShadow: [
                                  style.shadow,
                                ],
                              ),
                              child: Center(
                                  child: Text(e, style: style.keyTextStyle)),
                            ),
                          )),
                    );
                  }
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

const defaultSpecialKeys = {
  "shift": SpecialKey(name: "shift", icon: Icon(Icons.arrow_upward), extent: 2),
  "backspace": SpecialKey(
      name: "backspace",
      icon: Icon(Icons.backspace),
      extent: 2,
      allowRepeat: true),
  "enter":
      SpecialKey(name: "enter", icon: Icon(Icons.keyboard_return), extent: 2),
  "space": SpecialKey(
      name: "space", icon: Icon(Icons.space_bar), extent: 5, input: " "),
  "symbol": SpecialKey(name: "symbol", icon: Icon(Icons.keyboard)),
};


