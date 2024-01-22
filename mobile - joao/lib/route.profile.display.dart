import 'package:adm23194/components/button.wide.dart';
import 'package:flutter/material.dart';
import 'class.global.dart';
import 'server/server.user.data.dart' as s;
import 'components/card.profile.list.dart';

class RouteProfile extends StatefulWidget {
  const RouteProfile({Key? key}) : super(key: key);

  @override
  State<RouteProfile> createState() => _Page();
}
// controllers

class _Page extends State<RouteProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.primaryColor[0],
            iconTheme: const IconThemeData(color: AppColors.colorBlack),
            title: Text(Vars.routeProfileTitle,
                style: TextStyle(color: AppColors.primaryColor[1]))),
        body: SingleChildScrollView(
            child: Stack(children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30.0), // spacer
                  ElevatedCardProfile(
                      fetchTitle: s.fetchUserName(), iconData: Icons.person),
                  const SizedBox(height: 5.0), // spacer
                  ElevatedCardProfile(
                      fetchTitle: s.fetchUserEmail(), iconData: Icons.email),
                  const SizedBox(height: 5.0), // spacer
                  ElevatedCardProfile(
                      fetchTitle: s.fetchUserPhone(), iconData: Icons.phone),
                  const SizedBox(height: 5.0), // spacer
                  ElevatedCardProfile(
                      fetchTitle: s.fetchUserAddress(), iconData: Icons.home),
                  const SizedBox(height: 5.0), // spacer
                  ElevatedCardProfile(
                      fetchTitle: s.fetchUserDriver(),
                      iconData: Icons.drive_eta),
                  const SizedBox(height: 5.0), // spacer
                  ElevatedCardProfile(
                      fetchTitle: s.fetchUserProfile(),
                      iconData: Icons.business_center),
                  const SizedBox(height: 10.0), //spacer
                  btnWide(
                      title: 'Alterar Informações',
                      width: double.infinity,
                      colorBtn: AppColors.primaryColor[0],
                      colorTxt: AppColors.colorWhite,
                      screen: '/editProfile')
                ],
              ),
            ),
          ),
        ])));
  }
}
