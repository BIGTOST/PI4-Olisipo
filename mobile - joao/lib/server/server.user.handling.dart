import 'dart:math';
import 'package:adm23194/class.global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//variables
String? name;
FlutterSecureStorage storage = const FlutterSecureStorage();
//GET METHODS

//save token in header
Future<http.Response> authorizedGetRequest(String url) async {
  String? storedToken = await storage.read(key: 'token');
  if (storedToken != null) {
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
  if (response.statusCode == 200) {
    //PROCESSO
    responseData = jsonDecode(response.body);
    //String token = responseData['token'];
    print(mail);
    print(pass);
    //END PROCESSO
  } else {
    var errorData = jsonDecode(response.body);
    String errorMessage = errorData['message'];
    print(errorMessage);
    // Handle login failure, display error message, etc.
    print(responseData);
    print(mail);
    print(pass);
  }
}

Future<void> ErrorAlertDialog(BuildContext context, title, text) async {
  return showDialog<void>(
    context: context,
    //barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 400.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 300,
                      height: 130,
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(30, 215, 0, 1.0),
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(4.0))),
                      child: Center(
                        child: SizedBox(
                            width: 250,
                            height: 100,
                            child: Column(children: [
                              const Text(
                                'Aviso',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25,
                                    color: AppColors.colorBlack,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Calibri'),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                text,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: AppColors.colorBlack,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Calibri',
                                    fontWeight: FontWeight.normal),
                              )
                            ])),
                      ))
                ],
              ),
            )),
      );
    },
  );
}
