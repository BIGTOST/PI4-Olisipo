import 'dart:html';

import 'package:flutter/material.dart';
import 'class.global.dart';

import 'server/server.user.handling.dart' as s;
import 'server/server.user.data.dart' as n;
class RouteRecoverChangePassword extends StatefulWidget {
  const RouteRecoverChangePassword({super.key});

  @override
  State<RouteRecoverChangePassword> createState() => _Page();
}

class _Page extends State<RouteRecoverChangePassword> {
  TextEditingController recCodigo = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();

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
      body: Center(
        child: Column(children: [
            TextField(
                controller: recCodigo,
                decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(),
                labelText: 'Codigo enviado Para o email',
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25.0), // spacer
            ElevatedButton(
              onPressed: () {
                if(recCodigo.text =='' || newPassword.text ==''|| confirmNewPassword.text == ''){
                  print('campo email vazio');
                }else if(newPassword.text!=confirmNewPassword.text){//checagem para ver se o email segue a estrutura texto@texto.texto 
                  print('email not valid');
                }
                else{
                  String codigo = recCodigo.text;
                  n.recoverChangeUserPassword(
                      context,
                      codigo,
                      Vars.apiRoute
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
        )
      ),
    );
  }
}