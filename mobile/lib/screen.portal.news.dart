import 'package:flutter/material.dart';

class ScreenNews extends StatefulWidget {
  const ScreenNews({super.key});

  @override
  State<ScreenNews> createState() => _Page();
}

class _Page extends State<ScreenNews> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Ecrã de notícias'))
    );
  }
}