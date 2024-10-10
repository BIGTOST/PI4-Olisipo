import 'package:flutter/material.dart';
import 'class.global.dart';

class ScreenExpense extends StatefulWidget {
  const ScreenExpense({super.key});

  @override
  State<ScreenExpense> createState() => _Page();
}

class _Page extends State<ScreenExpense> {
  TextEditingController reasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Ajuda de Custos",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors
                        .primaryColor[0], // Change to your desired color
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Eu,",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: reasonController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    labelText: "Escreva a sua razão...",
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "desejo realizar um pedido de ajuda de custos.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor[0],
                      ),
                      child: Container(
                          child: const Text(
                        "Fazer Pedido",
                        style: TextStyle(color: AppColors.colorWhite),
                      )),
                      onPressed: () {},
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
