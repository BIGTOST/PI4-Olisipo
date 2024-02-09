import 'package:flutter/material.dart';
import 'class.global.dart';
import 'server/server.user.handling.dart' as s;

class RouteLogin extends StatefulWidget {
  const RouteLogin({Key? key}) : super(key: key);

  @override
  State<RouteLogin> createState() => _Page();
}
// controllers

class _Page extends State<RouteLogin> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor[0],
          iconTheme: const IconThemeData(color: AppColors.colorBlack),
          title: Text(Vars.routeLoginTitle,
              style: TextStyle(color: AppColors.primaryColor[1]))),
      body: Center(
        child: Container(
  
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 90.0), // spacer
              const Text(
                Vars.routeLandingWelcome1,
                style: TextStyle(
                  fontSize: 24.0,
                  //fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                Vars.routeLandingWelcome2,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),  // spacer
              const Text(
                Vars.routeLoginWelcome,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 10.0), // spacer
              TextField(
                controller: user,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: Vars.routeLoginUsername,
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
                  labelText: Vars.routeLoginPassword,
                  focusedBorder: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 25.0), // spaer
              ElevatedButton(
                onPressed: () {
                  if(user.text == ''|| pass.text ==''){
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Campo Vazio'),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('porfavor preencha todos os campos antes de prosseguir'),
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
                    String username = user.text; // Access username from the controller
                    String password = pass.text;
                    s.login(context, username, password,
                      Vars.apiRoute+'/user/login');
                  }
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50)),
                child: const Text(
                  'login',
                ),
              ),
              const SizedBox(height: 25.0), // spacer
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/recover');
                },
                child: const Text(
                  Vars.routeLoginRecover,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 5.0), // spacer
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  Vars.routeLoginRegist,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


