import 'package:flutter/material.dart';
import 'class.global.dart';
import 'components/theme.SwitchTheme.dart';
import 'server/server.dart' as s;

class RouteLanding extends StatefulWidget {
  const RouteLanding({Key? key}) : super(key: key);

  @override
  State<RouteLanding> createState() => _Page();
}

class _Page extends State<RouteLanding> {
  @override
  void initState() {
    //s.fetchData();
    //s.envio("https://backend-w7pc.onrender.com/user/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor[0],
          iconTheme: const IconThemeData(color: AppColors.colorBlack),
          title: Text(Vars.routeLandingTitle,
              style: TextStyle(color: AppColors.primaryColor[1]))),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30.0), // spacer
              const Text(
                Vars.routeLandingWelcome,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50.0), // spacer
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50)),
                child: const Text(
                  Vars.routeLandingLogin,
                ),
              ),
              const SizedBox(height: 25.0), // spacer
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50)),
                child: const Text(
                  Vars.routeLandingRegister,
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 30, 215, 0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    )
                  ],
                )),
            ThemeSwitch()
          ],
        ),
      ),
    );
  }
}
