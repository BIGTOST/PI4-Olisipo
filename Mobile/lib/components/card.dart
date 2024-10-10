import 'package:flutter/material.dart';


class ElevatedCardExample extends StatelessWidget {
  final String title;
  final String description;
  const ElevatedCardExample(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showDialog(
          context: context, 
          builder: (BuildContext context){
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineMedium
                        ),
                        const SizedBox(height: 16.0,),
                        Text(description)
                      ],
                    ),
                  ),
                  Positioned(
                    top:0.0,
                    right: 0.0,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            );
          }
        );
      },
      child:SizedBox(
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
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    )),
              ]
            )
          ),
        )
      ),
    );
  }
}
