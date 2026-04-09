import 'package:flutter/material.dart';


class Shortcut extends StatefulWidget {
  const Shortcut({super.key});

  @override
  State<Shortcut> createState() => _ShortcutState();
}

class _ShortcutState extends State<Shortcut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shortcuts Menu"),
      ),
      body: const Center(
        child: Text("This is the Shortcuts Menu page."),
      ),
    );
  }
}