//routes
import 'route.portal.dart';
import 'route.landing.dart';
import 'route.login.dart';
import 'route.recover.dart';
import 'route.register.dart';
//others
import 'package:flutter/material.dart';
import 'class.global.dart';
import 'package:provider/provider.dart';
import 'components/theme.themeProvider.dart';
import 'components/theme.checkMode.dart';

void main() {
  runApp(const MyApp());
}
bool mode = true;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
return ChangeNotifierProvider(
      create: (_) => ThemeProvider(), // Provide the ThemeProvider
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
        title: Vars.appName,
        theme: checkMode(context, themeProvider.isDarkMode),
        initialRoute: '/landing',
        routes: {
          '/landing': (context) => const RouteLanding(),
          '/login': (context) => const RouteLogin(),
           '/register': (context) => const RouteRegister(),
          '/recover': (context) => const RouteRecover(),
          '/portal': (context) => const RoutePortal(),
        });
  }));
  }
}