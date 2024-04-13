import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:embedded_keyboard/embedded_keyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  KeyboardMode _mode = KeyboardMode.normal;
  FocusNode _focusNode = FocusNode();

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Map<String, SpecialKey> specialKeys = Map.from(defaultSpecialKeys);
    switch (_mode) {
      case KeyboardMode.normal:
        break;
      case KeyboardMode.shift:
        specialKeys["shift"] = specialKeys["shift"]!
            .copyWith(overrideColor: Colors.lightBlue.shade200);
        break;
      case KeyboardMode.symbol:
        specialKeys["symbol"] = specialKeys["symbol"]!
            .copyWith(overrideColor: Colors.lightBlue.shade200);
        specialKeys["shift"] = specialKeys["shift"]!
            .copyWith(overrideColor: Colors.lightBlue.shade50);
        break;
      case KeyboardMode.shiftSymbol:
        specialKeys["shift"] = specialKeys["shift"]!
            .copyWith(overrideColor: Colors.lightBlue.shade200);
        specialKeys["symbol"] = specialKeys["symbol"]!
            .copyWith(overrideColor: Colors.lightBlue.shade200);
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Demo"),
      ),
      body: Column(
        children: [
          TextField(
            focusNode: _focusNode,
            controller: _controller,
          ),
          Spacer(),
          Container(
            height: 300,
            child: Keyboard(
              focusNode: _focusNode,
              mode: _mode,
              textController: _controller,
              layout: KeyboardLayouts.defaultLayout,
              specialKeys: specialKeys,
              onKeyPressed: (key) {
                setState(() {
                  _mode = KeyboardMode.normal;
                });
              },
              onSpecialKeyPressed: (key) {
                switch (key.name) {
                  case "shift":
                    setState(() {
                      _mode = _mode == KeyboardMode.normal
                          ? KeyboardMode.shift
                          : _mode == KeyboardMode.symbol
                              ? KeyboardMode.shiftSymbol
                              : KeyboardMode.normal;
                    });
                    break;
                  case "symbol":
                    setState(() {
                      _mode = _mode == KeyboardMode.normal
                          ? KeyboardMode.symbol
                          : _mode == KeyboardMode.shift
                              ? KeyboardMode.symbol
                              : KeyboardMode.normal;
                    });
                    break;
                  case "backspace":
                    final text = _controller.text;
                    if (text.isNotEmpty) {
                      _controller.text = text.substring(0, text.length - 1);
                    }
                    break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
