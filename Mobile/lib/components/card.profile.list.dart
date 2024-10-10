import 'package:flutter/material.dart';

class ElevatedCardProfile extends StatelessWidget {
  final Future<String> fetchTitle;
  final IconData iconData;
  
  
  const ElevatedCardProfile(
    {
      super.key,
      required this.fetchTitle,
      required this.iconData
    }
  );
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  leading: Icon(iconData),
                  title: FutureBuilder<String>(
                    future: fetchTitle, // Call your async function here
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Show a loading indicator while fetching the data
                        return const SizedBox(
                          width: 10.0,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        if (snapshot.hasError) {
                          // Show an error message if there's an error
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // Show the fetched username in your UI
                          return Text(
                            snapshot.data ?? "No username available",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Calibri',
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
