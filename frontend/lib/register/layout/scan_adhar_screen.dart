import 'package:flutter/material.dart';
import 'package:unscript_app/utils/unscript_theme.dart';

class ScanAdharScreen extends StatefulWidget {
  const ScanAdharScreen({super.key});

  @override
  State<ScanAdharScreen> createState() => _ScanAdharScreenState();
}

class _ScanAdharScreenState extends State<ScanAdharScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UnScriptTheme.backgroundColor,
    );
  }
}