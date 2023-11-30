import 'package:flutter/material.dart';

class ScreenTime extends StatefulWidget {
  const ScreenTime({super.key});

  @override
  State<ScreenTime> createState() => _Page();
}

class _Page extends State<ScreenTime> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Ecrã de registo de horas'))
    );
  }
}