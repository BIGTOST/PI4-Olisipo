import 'dart:math';
//import 'package:adm23194/server/server.token.user.data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:adm23194/server/server.token.payload.dart';

//variables
String? token;
String? name;

//GET METHODS

//obtain all data about users
Future<void> fetchData() async {
  var url = Uri.parse('http://mktiagoandre.ddns.net:8080/user');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    print(data);
  } else {
    print('Failed to fetch data: ${response.statusCode}');
  }
}

//obtain user's name to later display it in HomePage's MainHeader
Future<void> fetchUserName() async {
  var url = Uri.parse(
    'https://backend-w7pc.onrender.com/user',
  );

  var response = await http.get(
    url,
    headers: <String, String>{
      'authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    String _token = token.toString();
    var encodedPayload = _token.split('.')[1];
    var payloadData =
        utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    print(payloadData);
    final payload = Payload.fromJson(jsonDecode(payloadData));
    print(payload.id);
  }
}

//save token in header
Future<http.Response> authorizedGetRequest(String url) {
  if (token != null) {
    print('Token is filled: $token');
    return http.get(
      Uri.parse(url),
      headers: <String, String>{
        'authorization': 'Bearer $token',
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
    token = responseData['token']; //obtains token
    String? email = responseData['email'];

    //navigator
    Navigator.pushNamedAndRemoveUntil(context, '/portal', (route) => false);

    //methods
    authorizedGetRequest(url);
    print("Token in Header");
    fetchUserName();
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
      "profileUser": 1
    }),
  );
  var responseData;
  if (response.statusCode == 200) {
    //PROCESSO
    responseData = jsonDecode(response.body);
    //String token = responseData['token'];
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    // Handle successful login, save the token, navigate to the next screen, etc.

    print(mail);
    print(pass);
    //END PROCESSO
  } else {
    var errorData = jsonDecode(response.body);
    String errorMessage = errorData['message'];
    // Handle login failure, display error message, etc.
    print(responseData);
    print(mail);
    print(pass);
  }
}
