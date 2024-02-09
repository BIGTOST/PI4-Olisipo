import 'package:flutter/material.dart';
import '../class.global.dart';
import 'package:adm23194/server/server.user.data.dart' as s;

class HeroMain extends StatelessWidget {
  final String partner;

  const HeroMain({required this.partner});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SizedBox(
            width: 412,
            height: 100,
            child: Stack(children: [
              Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                          colorFilter: ColorFilter.mode(
                              Color.fromARGB(190, 0, 0, 0), BlendMode.darken),
                          fit: BoxFit.cover))),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FutureBuilder<String>(
                        future:
                            s.fetchUserName(), // Call your async function here
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // Show a loading indicator while fetching the data
                            return CircularProgressIndicator();
                          } else {
                            if (snapshot.hasError) {
                              // Show an error message if there's an error
                              return Text('Error: ${snapshot.error}');
                            } else {
                              // Show the fetched username in your UI
                              return Text(
                                snapshot.data ?? "No username available",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Calibri',
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.secondaryColor[1],
                                ),
                              );
                            }
                          }
                        },
                      )
                    ]
                  ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          partner,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Calibri',
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondaryColor[1],
                          ),
                        ),
                      ]
                    )
                  ),
          ]
        )
      )
    );
  }
}
