import 'package:flutter/material.dart';
import 'class.global.dart';
import 'server/server.user.handling.dart' as s;

class RouteRegister extends StatefulWidget {
  const RouteRegister({super.key});

  @override
  State<RouteRegister> createState() => _Page();
}

class _Page extends State<RouteRegister> {
  bool driver = false;
  TextEditingController user = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
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
                      labelText: Vars.routeRegisterUsername,
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
                    controller: phone,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      labelText: Vars.routeRegisterPhone,
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 25.0), // spacer
                  TextField(
                    controller: address,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      labelText: Vars.routeRegisterAddress,
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 25.0), // spacer
                  CheckboxListTile(
                    title: const Text(
                      Vars.routeRegisterDriver,
                      style: TextStyle(fontSize: 15.0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0), // Optionally
                      side: const BorderSide(color: AppColors.colorBlack),
                    ),
                    value: driver,
                    onChanged: (bool? value) {
                      setState(() {
                        driver =
                            value ?? false; // Update the value of _isChecked
                      });
                    },
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
                      String phoneN = phone.text;
                      String addr = address.text;
                      bool driverL = driver;
                      String password = pass.text;
                      s.regist(
                          context,
                          username,
                          email,
                          phoneN,
                          addr,
                          driverL,
                          password,
                          "https://backend-w7pc.onrender.com/user/regist");
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
