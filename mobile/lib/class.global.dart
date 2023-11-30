import 'package:flutter/material.dart';

class AppColors {
  // colors
  static const List<Color> primaryColor = [Color.fromRGBO(30, 215, 0, 1.0), Color.fromRGBO(0, 0, 0, 1.0)];
  static const List<Color> secondaryColor = [Color.fromRGBO(140, 70, 255, 1.0), Color.fromRGBO(255, 255, 255, 1.0)];
  static const List<Color> tertiaryColor = [Color.fromRGBO(0, 255, 255, 1.0), Color.fromRGBO(0, 0, 0, 1.0)];
  static const Color colorBlack = Color.fromRGBO(0, 0, 0, 1.0);
  static const Color colorWhite = Color.fromRGBO(255, 255, 255, 1.0);
}

class Vars {
  // app
  static const String appName = 'Olisipo';
  // route.landing.dart
  static const String routeLandingTitle = 'Portal do Colaborador';
  static const String routeLandingWelcome = 'Bem vindo ao novo portal do colaborador Olisipo';
  static const String routeLandingLogin = 'Utilizador registado';
  static const String routeLandingRegister = 'Efetuar registo';
  // route.login.dart
  static const String routeLoginTitle = 'Efetuar login';
  static const String routeLoginWelcome = 'Introduza os dados para iniciar sessão';
  static const String routeLoginUsername = 'Login com username ou email';
  static const String routeLoginPassword = 'Palavra passe';
  static const String routeLoginValidate = 'Entrar';
  static const String routeLoginError = 'Dados para login inválidos';
  static const String routeLoginRecover = 'Recuperar palavra passe';
  // page.register.dart
  static const String routeRegisterTitle = 'Efetuar registo';
  // page.recover.dart
  static const String routeRecoverTitle = 'Recuperar palavra passe';
  // page.portal.dart
  static const String routePortalTitle = 'Portal do Colaborador';
  static const String routePortalNews = 'Notícias';
  static const String routePortalTime = 'Horas';
  static const String routePortalExpense = 'Despesas';
  static const String routePortalMeeting = 'Reuniões';
    static const String routeDashboard = 'Dashboard';
}