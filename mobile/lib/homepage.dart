import 'package:flutter/material.dart';
import 'package:adm23194/widgets/heroMain.dart';
import 'package:adm23194/widgets/card.dart';
import 'package:adm23194/widgets/button_wide.dart';
import 'package:adm23194/widgets/bottomNavBar.dart';

class homePage extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text(
              "Dashboard",
              style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white),
            ),
            SizedBox(width: 125),
            Text(
              "Notícias",
              style: TextStyle(color: Colors.white),
            ),
          ])
          //title: Text(widget.title)
          ),
      body: const Stack(
        children: [
          Column(children: [
            HeroMain(
              name: "Joaquim Almeida Sousa",
              partner: "Quint",
            ),
            SizedBox(height:16),
            btnWide(title: "Submissão de Horas", width: 300, colorBtn: Colors.black, colorTxt: Colors.white,screen: ''),
            SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(children: [
                ElevatedCardExample(
                  title: "Reuniões",
                  description: "Faça o pedido para ter uma reunião",
                ),
                ElevatedCardExample(
                  title: "Ajuda de custos",
                  description: "Peça uma ajuda",
                ),
              ]),
              Column(children: [
                ElevatedCardExample(
                  title: "Pedido de Férias",
                  description: "Realize um pedido",
                ),
                ElevatedCardExample(
                  //title: "Arquivo de Declarações",
                  title: "Declarações",
                  description: "Veja o arquivo",
                ),
                BottomNavigationBarExample()
              ])
            ])
          ]),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 30, 30, 30),
    );
  }
}
