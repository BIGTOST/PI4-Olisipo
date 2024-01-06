import 'package:http/http.dart' as http;
import 'dart:convert';
import '../route.login.dart' as l;
import 'package:flutter/material.dart';

Future<void> fetchData() async {
  var url = Uri.parse('https://backend-w7pc.onrender.com/user');

  // Making the GET request
  var response = await http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON response
    var data = json.decode(response.body);
    // Handle the data here
    print(data);
  } else {
    // If the server did not return a 200 OK response,
    // handle the error by checking response.statusCode
    print('Failed to fetch data: ${response.statusCode}');
  }
}

Future<void> envio(BuildContext context, user, pass, url) async {
  var response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "email": user,
      "password": pass
    }),
  );
  var responseData;
 if (response.statusCode == 200) {
        responseData = jsonDecode(response.body);
        //String token = responseData['token'];
        Navigator.pushNamedAndRemoveUntil(context, '/portal', (route) => false);
        // Handle successful login, save the token, navigate to the next screen, etc.
              print(user);
        print(pass);
      } else {
        var errorData = jsonDecode(response.body);
        String errorMessage = errorData['message'];
        // Handle login failure, display error message, etc.
        print(responseData);
        print(user);
        print(pass);
      }
    }
