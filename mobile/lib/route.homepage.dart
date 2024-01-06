import 'package:flutter/material.dart';
import 'components/heroMain.dart';
import 'components/card.dart';
import 'components/button.wide.dart';
import 'components/items.wide.dart';

class homePage extends StatelessWidget {
  bool check = false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: SingleChildScrollView(
          child: Stack(
        children: [
          Column(children: [
            //MenuHeader(title1: 'Dashboard', title2: 'Notícias'),
            HeroMain(
              partner: "Quint",
            ),
            SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(children: [
                                ElevatedCardExample(
                  title: "Pedido de Férias",
                  description: "Realize um pedido",
                ),
               /* ElevatedCardExample(
                  title: "Reuniões",
                  description: "Realize um pedido",
                ),
                ElevatedCardExample(
                  title: "Ajuda de custos",
                  description: "Peça uma ajuda",
                ),*/
              ]),
              Column(children: [
                /*ElevatedCardExample(
                  title: "Pedido de Férias",
                  description: "Realize um pedido",
                ),*/
                ElevatedCardExample(
                  //title: "Arquivo de Declarações",
                  title: "Declarações",
                  description: "Veja o arquivo",
                )
              ])
            ]),
            SizedBox(height: 16),
            btnWide(
                title: "Submissão de Horas",
                width: 380,
                colorBtn: Color.fromARGB(255, 30, 215, 0),
                colorTxt: Colors.white,
                screen: '/test'),
            SizedBox(height: 16),
            Items_Wide(
              title1: 'com Manager',
              icon: Icons.calendar_month,
              title2: '27/11/2023',
            ),
            SizedBox(height: 4),
            Items_Wide(
              title1: 'com Manager',
              icon: Icons.calendar_month,
              title2: '28/11/2023',
            ),
            SizedBox(height: 4),
            Items_Wide(
              title1: 'com Manager',
              icon: Icons.calendar_month,
              title2: '29/11/2023',
            ),
            SizedBox(height: 4),
            Items_Wide(
              title1: 'com Manager',
              icon: Icons.calendar_month,
              title2: '30/11/2023',
            ),
            SizedBox(height: 4),
            Items_Wide(
              title1: 'com Manager',
              icon: Icons.calendar_month,
              title2: '01/12/2023',
            ),
            SizedBox(height: 16),
          ]),
        ],
      )),
    );
  }
}
