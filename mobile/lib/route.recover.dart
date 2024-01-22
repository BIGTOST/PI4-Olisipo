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
                      print('campo email vazio');
                    }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(mail.text)){//checagem para ver se o email segue a estrutura texto@texto.texto 
                      print('email not valid');
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