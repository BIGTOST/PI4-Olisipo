import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../class.global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//variables
String? name;
String apiroute= Vars.apiRoute;
FlutterSecureStorage storage = const  FlutterSecureStorage();
//GET METHODS

//save token in header
Future<http.Response> authorizedGetRequest(String url) async {
  String? storedToken = await storage.read(key: 'token');
  if (storedToken  != null) {
    print('Token is filled: $storedToken ');
    return http.get(
      Uri.parse(url),
      headers: <String, String>{
        'authorization': 'Bearer $storedToken ',
      },
    );
  } else {
    throw Exception('Token not available: $e');
  }
}

//POST METHODS
//login
Future<void> login(BuildContext context, user, pass, url) async {
  var response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"email": user, "password": pass}),
  );
  var responseData;
  if (response.statusCode == 200) {
    //PROCESSO
    responseData = jsonDecode(response.body);
    //set variables with json body
    var token = responseData['token']; //obtains token
    await storage.write(key: 'token', value: token!);

    //navigator
    Navigator.pushNamedAndRemoveUntil(context, '/portal', (route) => false);

    //methods
    authorizedGetRequest(url);
    print("Token in Header");
    print("UserName encontrado");

    //prints
    print(user);
    print(pass);
    print(token);
    print("login successful");
    //END PROCESSO
  } else {
    var errorData = jsonDecode(response.body);
    String errorMessage = errorData['message'];
    print("there has been an error: $errorMessage");
    // Handle login failure, display error message, etc.
    print(responseData);
    print(user);
    print(pass);
  }
}

//regist
Future<void> regist(BuildContext context, userName, mail, pass, url) async {
  var response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "name": userName,
      "email": mail,
      "password": pass,
      "driver": false,
      "profileUser": 1
    }),
  );
  var responseData;
  if (response.statusCode == 201) {
    //PROCESSO
    responseData = jsonDecode(response.body);
    //String token = responseData['token'];
    // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    // Handle successful login, save the token, navigate to the next screen, etc.

    print(mail);
    print(pass);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('LogIn Aprovado'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Registro feito com sucesso'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('fechar'),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
            ),
          ],
        );
      },
    );
    //END PROCESSO
  } else if(response.statusCode == 409){
    var errorData = jsonDecode(response.body);
    String errorMessage = errorData['message'];
    print(errorMessage);
    print(mail);
    print(pass);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro de email'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Email Já exist'),
                Text('O email que tentou introduzir já encontra-se registrado'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('LogIn'),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
            ),
            TextButton(
              child: const Text('fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }else{
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro de email'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Algo deu Errado'),
                Text('De momento estamos a ter algumas dificuldades com o sistema, tente novamente mais tarde'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('fechar'),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/landing', (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
}

//recover password request
Future<void> recoverQuery(BuildContext context, mail,url) async {
  var response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "email": mail,
    }),
  );
    var responseData;
   if (response.statusCode == 200) {
    //PROCESSO
    responseData = jsonDecode(response.body);
    String texto = responseData['message'];
    var token = responseData['token']; //obtains token
    await storage.write(key: 'token', value: token!);
    //String token = responseData['token'];
    // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    // Handle successful login, save the token, navigate to the next screen, etc.
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('LogIn Aprovado'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                 Text('Foi enviado para o seu email um codigo para que possa alterar a password'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('proceguir'),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/recoverPasswordChange', (route) => false);
              },
            ),
          ],
        );
      },
    );
    //END PROCESSO
  } else if(response.statusCode == 404){
    var errorData = jsonDecode(response.body);
    String errorMessage = errorData['message'];
    print(errorMessage);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro de email'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Email não encontrado'),
                Text('O email que tentou introduzir não consta no sistema'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }else{
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro de email'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Algo deu Errado'),
                Text('De momento estamos a ter algumas dificuldades com o sistema, tente novamente mais tarde'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('fechar'),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/landing', (route) => false);
              },
            ),
          ],
        );
      },
    );
  }
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Nova Password Gerada'),
  //         content: const SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Uma nova password foi gerada e enviada para o seu email.'),
  //               Text('Porfavor tente realizar login novamente  com a nova password'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('fechar'),
  //             onPressed: () {
  //               Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  //   //END PROCESSO
  // } else if(response.statusCode == 409){
  //   var errorData = jsonDecode(response.body);
  //   String errorMessage = errorData['message'];
  //   print(errorMessage);
  //   print(mail);
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Erro de email'),
  //         content: const SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Email Já exist'),
  //               Text('O email que tentou introduzir já encontra-se registrado'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('LogIn'),
  //             onPressed: () {
  //               Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  //             },
  //           ),
  //           TextButton(
  //             child: const Text('fechar'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }else{
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Erro de email'),
  //         content: const SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Algo deu Errado'),
  //               Text('De momento estamos a ter algumas dificuldades com o sistema, tente novamente mais tarde'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('fechar'),
  //             onPressed: () {
  //               Navigator.pushNamedAndRemoveUntil(context, '/landing', (route) => false);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}

Future<void> recoverChangeUserPassword(BuildContext context, codigo, newPassword, confirmNewPassword, url) async {
  String? storedToken = await storage.read(key: 'token');

  var response = await http.post(
    Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $storedToken',
      },
      body: jsonEncode({
        "codigo":codigo,
        "newPassword":newPassword,
        "confirmNewPassword":confirmNewPassword
      }));
  print(response.statusCode);
  if (response.statusCode == 200) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Palavra Pass Alterada'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('A sua palavra pass foi atualizada com sucesso'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('fechar'),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
            ),
          ],
        );
      },
    );
  } else {
    throw const Text('Error has ocurred: $e');
  }
}
