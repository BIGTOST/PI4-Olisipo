import 'package:flutter/material.dart';

class ScreenMeeting extends StatefulWidget {
  const ScreenMeeting({super.key});

  @override
  State<ScreenMeeting> createState() => _Page();
}

class _Page extends State<ScreenMeeting> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Ecrã de agendamneto de reuniões com Manager'))
    );
  }
}