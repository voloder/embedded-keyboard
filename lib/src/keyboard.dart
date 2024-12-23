import 'dart:async';

import 'package:embedded_keyboard/src/keyboard_layout.dart';
import 'package:embedded_keyboard/src/keyboard_style.dart';
import 'package:embedded_keyboard/src/special_key.dart';
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
  final bool retract;
  final Duration slideAnimationDuration;
  final Curve slideAnimationCurve;

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
    this.retract = false,
    this.slideAnimationDuration = const Duration(milliseconds: 200),
    this.slideAnimationCurve = Curves.easeInOut,
  }) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  late KeyboardStyle style = widget.style ?? KeyboardStyle();
  late bool keyboardVisible = !widget.retract;

  Timer? _repeatTimer;
  Timer? _longPressTimer;
  Timer? _keyboardVisibilityTimer;

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(() {
      if (!widget.retract) return;

      print(widget.focusNode?.hasFocus);
      if (widget.focusNode?.hasFocus ?? false) {
        _keyboardVisibilityTimer?.cancel();
        setState(() {
          keyboardVisible = true;
        });
      } else {
        _keyboardVisibilityTimer = Timer(const Duration(milliseconds: 100), () {
          setState(() {
            keyboardVisible = false;
          });
        });
      }
    });
  }

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
    return AnimatedSlide(
      offset: keyboardVisible ? Offset.zero : const Offset(0, 1),
      duration: widget.slideAnimationDuration,
      curve: widget.slideAnimationCurve,
      child: Container(
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
                            behavior: HitTestBehavior.translucent,
                            onTapDown: (details) {
                              requestFocusIfUnfocused();

                              _longPressTimer =
                                  Timer(Duration(milliseconds: 500), () {
                                if (key.allowRepeat) {
                                  _repeatTimer = Timer.periodic(
                                      const Duration(milliseconds: 50),
                                      (timer) {
                                    widget.onSpecialKeyPressed?.call(key);
                                    if (key.input != null) {
                                      widget.textController?.text += key.input!;
                                    }
                                    requestFocusIfUnfocused();
                                  });
                                }
                              });
                            },
                            onTapUp: (event) {
                              _longPressTimer?.cancel();
                              _repeatTimer?.cancel();
                              widget.onSpecialKeyPressed?.call(key);
                              if (key.input != null) {
                                widget.textController?.text += key.input!;
                              }

                              requestFocusIfUnfocused();
                            },
                            child: Padding(
                              padding: style.keyPadding,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: style.keyBorder,
                                  borderRadius: style.borderRadius,
                                  color: key.overrideColor ?? style.keyColor,
                                  boxShadow: [
                                    style.shadow,
                                  ],
                                ),
                                child:
                                    Center(child: widget.specialKeys[e]!.icon),
                              ),
                            )),
                      );
                    } else {
                      return Expanded(
                        child: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTapDown: (details) {
                              requestFocusIfUnfocused();
                            },
                            onTapUp: (event) {
                              widget.onKeyPressed?.call(e);
                              widget.textController?.text += e;
                              requestFocusIfUnfocused();
                            },
                            child: Padding(
                              padding: style.keyPadding,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: style.keyBorder,
                                  color: style.keyColor,
                                  borderRadius: style.borderRadius,
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
      ),
    );
  }

  void requestFocusIfUnfocused() {
    if (!(widget.focusNode?.hasFocus ?? false)) {
      widget.focusNode?.requestFocus();

      widget.textController?.selection = TextSelection.collapsed(
        offset: widget.textController!.text.length,
      );
    }
  }
}
