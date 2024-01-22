
import 'package:flutter/material.dart';
import 'class.global.dart';

import 'server/server.user.handling.dart' as s;
class RouteRecoverChangePassword extends StatefulWidget {
  const RouteRecoverChangePassword({super.key});

  @override
  State<RouteRecoverChangePassword> createState() => _Page();
}

class _Page extends State<RouteRecoverChangePassword> {
  TextEditingController recCodigo = TextEditingController();
  TextEditingController inputNewPassword = TextEditingController();
  TextEditingController inputConfirmNewPassword = TextEditingController();

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
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: recCodigo,
                  decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'Codigo enviado Para o email',
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                  controller: inputNewPassword,
                  decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'Nova Password',
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                  controller: inputConfirmNewPassword,
                  decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'Confirmação de Nova Password',
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25.0), // spacer
              ElevatedButton(
                onPressed: () {
                  if(recCodigo.text =='' || inputNewPassword.text ==''|| inputConfirmNewPassword.text == ''){
                    print('preencha todos os campos');
                  }else if(inputNewPassword.text!= inputConfirmNewPassword.text){//checagem para ver se o email segue a estrutura texto@texto.texto 
                    print('email not valid');
                  }
                  else{
                    String codigo = recCodigo.text,
                           newPassword = inputNewPassword.text,
                           confirmNewPassword = inputConfirmNewPassword.text;
                    s.recoverChangeUserPassword(
                        context,
                        codigo,
                        newPassword,
                        confirmNewPassword,
                        Vars.apiRoute + '/user/recoverChagePass'
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
        )
      ),
    );
  }
}