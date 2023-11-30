import 'package:flutter/material.dart';

class ScreenExpense extends StatefulWidget {
  const ScreenExpense({super.key});

  @override
  State<ScreenExpense> createState() => _Page();
}

class _Page extends State<ScreenExpense> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Ecrã de pedido de ajudas de custo'))
    );
  }
}