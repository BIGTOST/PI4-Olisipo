import 'package:flutter/material.dart';

class ElevatedCardExample extends StatelessWidget {
  final String title;
  final String description;
  const ElevatedCardExample(
      {super.key, required this.title, required this.description});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Column(children: <Widget>[
                Container(
                  height: 10,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 0, 255, 255),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(4.0))),
                ),
                ListTile(
                    title: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Calibri',
                            fontWeight: FontWeight.w700,
                          ),
                        )),
                    subtitle: Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Calibri',
                      ),
                    )),
              ])),
        ));
  }
}
