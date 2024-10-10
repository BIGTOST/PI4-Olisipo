import 'package:flutter/material.dart';

class Items_Wide extends StatelessWidget {
  final String title1;
  final String title2;
  final IconData icon;
  const Items_Wide(
    {
      super.key,
      required this.title1,
      required this.icon,
      required this.title2
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      width: 380,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            icon,
            color: const Color.fromARGB(255, 30, 215, 0),
          ),
          const SizedBox(
            width: 8,
          ),
          const Text(
            'Reunião',
            style: TextStyle(
              color: Color.fromARGB(255, 30, 215, 0),
              fontSize: 18,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            title1,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          Text(
            title2,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ]
      ),
    );
  }
}
