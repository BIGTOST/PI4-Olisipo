import 'package:adm23194/route.recover.process.dart';
import 'package:flutter/material.dart';
import 'class.global.dart';
import 'server/server.user.handling.dart' as s;

class RouteRecover extends StatefulWidget {
  const RouteRecover({super.key});

  @override
  State<RouteRecover> createState() => _Page();
}

class _Page extends State<RouteRecover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.secondaryColor[0],
          title: Text(Vars.routeRecoverTitle,
              style: TextStyle(color: AppColors.secondaryColor[1]))),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 25.0), // spacer
              const Text(
                Vars.routeRecoverEmail,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0), // spacer
              const TextField(
                //controller: textField,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: "Email",
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25.0), // spacer
              ElevatedButton(
                onPressed: () {
                  //mandar email com código
                  s.ErrorAlertDialog(context, "Aviso",
                      "Se o email existir, será enviado um código.");
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: AppColors.secondaryColor[0]),
                child: const Text(
                  Vars.routeRecoverValidate,
                ),
              ),
              const SizedBox(height: 45.0), // spacer
              const Text(
                Vars.routeRecoverCode,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0), // spacer
              const TextField(
                //controller: textField,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: "Código",
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25.0), // spacer
              ElevatedButton(
                onPressed: () {
                  //começar processo se correto
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecoverProcess()));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: AppColors.secondaryColor[0]),
                child: const Text(
                  Vars.routeRecoverValidate,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
