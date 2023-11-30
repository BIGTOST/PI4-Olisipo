import 'package:flutter/material.dart';
import 'class.global.dart';

class RouteRegister extends StatefulWidget {
  const RouteRegister({super.key});

  @override
  State<RouteRegister> createState() => _Page();
}

class _Page extends State<RouteRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor[0],
        title: Text(
            Vars.routeRegisterTitle,
            style: TextStyle(color: AppColors.primaryColor[1])
          )
      ),
    );
  }
}