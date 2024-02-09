import 'dart:math';
//import 'package:adm23194/class.global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:flutter/material.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<List<String>> ListItems() async{
  List<String> items = [];
    var response = await http.get(
    Uri.parse("https://backend-w7pc.onrender.com/news/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }
  );
  var responseData;
  if (response.statusCode == 200) {
    responseData = jsonDecode(response.body);
    String title = responseData['tittle'];
    List<Map<String, Object?>> resultData = await responseData;
    resultData.forEach((linha) {
      items.add(linha.toString());
    });
  }
  return items;
}