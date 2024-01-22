import 'package:flutter/material.dart';
import 'class.global.dart';
import 'server/server.user.handling.dart' as s;

class RecoverProcess extends StatefulWidget {
  const RecoverProcess({super.key});

  @override
  State<RecoverProcess> createState() => _Page();
}

class _Page extends State<RecoverProcess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.secondaryColor[0],
          title: Text(Vars.routeRecoverProcessTitle,
              style: TextStyle(color: AppColors.secondaryColor[1]))),
      body:Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30.0), // spacer
              const Text(
                Vars.routeRecoverProcessNewPass,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25.0), // spacer
              const TextField(
                //controller: textField,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: "Nova palavra-passe",
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 50.0), // spacer
              const Text(
                Vars.routeRecoverProcessNewPass2,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25.0), // spacer
              const TextField(
                //controller: textField,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: "Nova palavra-passe",
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25.0), // spacer
              ElevatedButton(
                onPressed: () {
                  //começar processo se correto
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/landing', (route) => false);
                  s.ErrorAlertDialog(context, "Aviso",
                      "A sua nova palavra-passe foi definida.");
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: AppColors.secondaryColor[0]),
                child: const Text(
                  Vars.routeRecoverProcessValidate,
                ),
              ),
            ],
          ),
        ),
      );
  }
}
