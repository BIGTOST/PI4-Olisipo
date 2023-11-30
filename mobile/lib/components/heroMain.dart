import 'package:flutter/material.dart';
import '../class.global.dart';

class HeroMain extends StatelessWidget {
  final String name;
  final String partner;

  const HeroMain({required this.name, required this.partner});
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
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Calibri',
                          fontWeight: FontWeight.w700,
                          color: AppColors.secondaryColor[1],
                        ),
                      ),
                    ]),
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
                      ])),
            ])));
  }
}
