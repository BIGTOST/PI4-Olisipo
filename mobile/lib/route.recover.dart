import 'package:flutter/material.dart';
import 'class.global.dart';

import 'server/server.user.handling.dart' as s;
class RouteRecover extends StatefulWidget {
  const RouteRecover({super.key});

  @override
  State<RouteRecover> createState() => _Page();
}

class _Page extends State<RouteRecover> {
  TextEditingController mail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor[0],
        title: Text(
            Vars.routeRecoverTitle,
            style: TextStyle(color: AppColors.secondaryColor[1])
          )
      ),
      body:Center(
        
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Introduza o seu email no campo abaixo',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2.0),
                TextField(
                    controller: mail,
                    decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    labelText: Vars.routeRegisterEmail,
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 25.0), // spacer
                ElevatedButton(
                  onPressed: () {
                    if(mail.text ==''){
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Campo Vazio'),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('Campo de email vazio'),
                                  Text('porfavor preencha o  campo de email antes de proceguir'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('close'),
                                onPressed: () {
                                   Navigator.pop(context); //close Dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(mail.text)){//checagem para ver se o email segue a estrutura texto@texto.texto 
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Dados Ivalidos'),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('Email introduzido é invalido'),
                                  Text('porfavor preencha o  campo de email com um email valido'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('close'),
                                onPressed: () {
                                   Navigator.pop(context); //close Dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                    else{
                      String email = mail.text;
                      print(email+" pagina de recover");
                      s.recoverQuery(
                          context,
                          email,
                          Vars.apiRoute+'/user/recover'
                          );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50)),
                        child: const Text(
                          Vars.routeRegisterValidate,
                        ),
                      ),
              ],
            
          ),
        ),
      ),
    );
  }
}