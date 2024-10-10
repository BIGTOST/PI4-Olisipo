import 'package:flutter/material.dart';
import 'class.global.dart';
import 'server/server.user.data.dart' as s;

class RouteProfileEdit extends StatefulWidget {
  const RouteProfileEdit({Key? key}) : super(key: key);

  @override
  State<RouteProfileEdit> createState() => _Page();
}
// controllers

class _Page extends State<RouteProfileEdit> {
  TextEditingController user = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  bool driver = false;

  @override
  void initState() {
    super.initState();
    fetchAndSetUserInfo(); // Call the method to fetch and set the username
  }

  Future<void> fetchAndSetUserInfo() async {
    String fetchedUserName = await s.fetchUserName();
    String fetchedUserEmail = await s.fetchUserEmail();
    String fetchedUserPhone = await s.fetchUserPhone();
    String fetchedUserAddress = await s.fetchUserAddress();
    String fetchedUserDriver = await s.fetchUserDriver();
    setState(() {
      user.text = fetchedUserName;
      mail.text = fetchedUserEmail;
      phone.text = fetchedUserPhone;
      address.text = fetchedUserAddress;
      if(fetchedUserDriver == "Possui"){
        driver = true;
      }else if(fetchedUserDriver =="Não Possui"){
        driver = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.primaryColor[0],
            iconTheme: const IconThemeData(color: AppColors.colorBlack),
            title: Text(Vars.routeProfileEditTitle,
                style: TextStyle(color: AppColors.primaryColor[1]))),
        body: SingleChildScrollView(
            child: Stack(children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30.0), // spacer
                  const SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Card(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                Text(
                                  "Alterar o nome de utilizador",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Calibri',
                                  ),
                                )
                              ])))),
                  const SizedBox(height: 5),
                  TextField(
                    controller: user,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 5.0), // spacer
                  const SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Alterar email",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Calibri',
                              ),
                            )
                          ]
                        )
                      )
                    )
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: mail,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 5.0), // spacer
                  const SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Alterar o número de telemóvel",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Calibri',
                              ),
                            )
                          ]
                        )
                      )
                    )
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: phone,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 5.0), // spacer
                  const SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Alterar a morada",
                              textAlign: TextAlign.center,
                                style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Calibri',
                              ),
                            )
                          ]
                        )
                      )
                    )
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: address,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 5.0), // spacer
                  const SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  "Alterar o estado de condutor",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Calibri',
                                  ),
                                )
                              ])))),
                  const SizedBox(height: 5),
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
                  const SizedBox(height: 15.0), //spacer
                  ElevatedButton(
                    onPressed: () {
                      String username = user.text;
                      String email = mail.text;
                      String phoneN = phone.text;
                      String addr = address.text;
                      bool driverL = driver;
                      s.updateUserName(
                        username,
                        email,
                        phoneN,
                        addr,
                        driverL,
                      );
                      Navigator.of(context)
                          .popUntil(ModalRoute.withName('/portal'));
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50)),
                    child: const Text(
                      Vars.routeLoginValidate,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ])));
  }
}
