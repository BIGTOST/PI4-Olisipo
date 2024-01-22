import 'package:flutter/material.dart';
import 'class.global.dart';
import 'server/server.user.handling.dart' as s;
import 'server/server.user.data.dart' as data;

class RouteRegister extends StatefulWidget {
  const RouteRegister({super.key});

  @override
  State<RouteRegister> createState() => _Page();
}

class _Page extends State<RouteRegister> {
  bool driver = false;
  TextEditingController user = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.primaryColor[0],
            iconTheme: const IconThemeData(color: AppColors.colorBlack),
            title: Text(Vars.routeRegisterTitle,
                style: TextStyle(color: AppColors.primaryColor[1]))),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30.0), // spacer
                  const Text(
                    Vars.routeRegisterTitle,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50.0), // spacer
                  TextField(
                    controller: user,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      labelText: Vars.routeRegisterUsername2,
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 25.0), // spacer
                  TextField(
                    controller: mail,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.colorBlack),
                      ),
                      labelText: Vars.routeRegisterEmail,
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 25.0), // spacer
                  TextField(
                    controller: pass,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.colorBlack),
                      ),
                      labelText: Vars.routeRegisterPassword,
                      focusedBorder: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 25.0), // spacer
                  ElevatedButton(
                    onPressed: () {
                      String username = user.text;
                      String email = mail.text;
                      String password = pass.text;
                      if (username.isEmpty ||
                          email.isEmpty ||
                          password.isEmpty) {
                        s.ErrorAlertDialog(
                            context, "Aviso", "Existem dados por preencher");
                      } else {
                        print(username.length);
                        if (username.length <= 20) {
                          if (username.contains(RegExp(
                              r'^[a-zA-ZÀ-ÖØ-öø-ÿ]+( [a-zA-ZÀ-ÖØ-öø-ÿ]+)?$'))) {
                            if (email.contains(RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z]+"))) {
                                if (password.contains(RegExp(
                                  r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^\da-zA-Z]).+$',
                                ))) {
                                  s.regist(context, username, email, password,
                                      Vars.backendUserRegister);
                                  s.ErrorAlertDialog(context, "Registo",
                                      "A sua conta foi criada com sucesso");
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/landing', (route) => false);
                                } else {
                                  s.ErrorAlertDialog(context, "Aviso",
                                      "A palavra-passe não é válida");
                                }
                            } else {
                              s.ErrorAlertDialog(
                                  context, "Aviso", "O email não é válido");
                            }
                          } else {
                            s.ErrorAlertDialog(
                                context, "Aviso", "O nome não é válido");
                          }
                        } else {
                          s.ErrorAlertDialog(
                              context, "Aviso", "O nome é demasiado longo");
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50)),
                    child: const Text(
                      Vars.routeRegisterValidate,
                    ),
                  ),
                  const SizedBox(height: 25.0), // spacer
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      Vars.routeRegisterHaveLogin,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
