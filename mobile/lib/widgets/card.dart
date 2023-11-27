import 'package:flutter/material.dart';

class ElevatedCardExample extends StatelessWidget {
  final String title;
  final String description;
  const ElevatedCardExample(
      {super.key, required this.title, required this.description});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 170,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Card(
              color: Colors.black,
              child: Column(children: <Widget>[
                Container(
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 255, 255),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(8.0))),
                ),
                ListTile(
                    title: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Calibri',
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    subtitle: Text(
                      description,
                      style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Calibri',
                          color: Colors.white),
                    )),
              ])),
        ));
  }
}
