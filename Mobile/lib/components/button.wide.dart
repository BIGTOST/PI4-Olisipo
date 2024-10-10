import 'package:flutter/material.dart';

class btnWide extends StatelessWidget {
  final String title;
  final double width;
  final Color colorBtn;
  final Color colorTxt;
  final String screen;
  const btnWide(
    {
      super.key,
      required this.title,
      required this.width,
      required this.colorBtn,
      required this.colorTxt,
      required this.screen
    }
  );
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorBtn,
          ),
          child: Container(
              child: Text(
            title,
            style: TextStyle(color: colorTxt),
          )),
          onPressed: () {
            Navigator.pushNamed(context, screen);
          },
        ));
  }
}
