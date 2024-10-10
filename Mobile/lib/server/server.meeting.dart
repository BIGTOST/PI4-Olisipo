import 'dart:math';
//import 'package:adm23194/class.global.dart';
import 'package:adm23194/server/server.event.dart';
import 'package:adm23194/server/server.user.data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../class.global.dart';
import 'package:flutter/material.dart';


var token = getToken();




Future<List<Map<String, dynamic>>> ListItems(String url) async{
  List<Map<String,dynamic>> resultData = [];
    var response = await http.get(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    }
  );

  var responseData;
  if (response.statusCode == 200) {
    responseData = jsonDecode(response.body);
    print(responseData);
    List<dynamic> dataItens = await responseData['data'];
    
    resultData = dataItens.map((item){
      return{
        'tittle':item['tittle'].toString(),
        'text':item['text']
      };
    }).toList();

    print(resultData);
  }
  return resultData;
}