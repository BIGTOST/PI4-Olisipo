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
              const SizedBox(height: 30.0), // spacer
              const Text(
                Vars.routeLoginWelcome,
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
                  String username =
                      user.text; // Access username from the controller
                  String password = pass.text;
                  s.login(context, username, password,
                      Vars.apiRoute+'/user/login');
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50)),
                child: const Text(
                  Vars.routeLoginValidate,
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
            ],
          ),
        ),
      ),
    );
  }
}
