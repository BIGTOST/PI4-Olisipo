import 'package:flutter/material.dart';
import 'class.global.dart';

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
        title: Text(
            Vars.routeRecoverTitle,
            style: TextStyle(color: AppColors.secondaryColor[1])
          )
      ),
    );
  }
}