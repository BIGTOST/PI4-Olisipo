import 'package:flutter/material.dart';

class MenuHeader extends StatelessWidget {
  final String title1;
  final String title2;
  const MenuHeader({super.key, required this.title1, required this.title2});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: 50,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          title1,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        const SizedBox(width: 150),
        Text(
          title2,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        )
      ]),
    );
  }
}
