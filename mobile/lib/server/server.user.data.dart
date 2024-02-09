import 'dart:ffi';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../class.global.dart';
import 'package:flutter/material.dart';
import 'package:adm23194/server/server.token.payload.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//variables
String? name;
String apiroute= Vars.apiRoute;
FlutterSecureStorage storage = const FlutterSecureStorage();

//GET METHODS

//obtain user's id
Future<int> fetchUserID() async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    apiroute +'/user/encontra',
  );

  var response = await http.get(
    url,
    headers: <String, String>{
      'authorization': 'Bearer $storedToken',
    },
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    String _token = storedToken.toString();
    int user = 0;
    var lista = jsonDecode(response.body)['data'];

    lista.forEach((linha) {
      if (linha['idUser'] != 'null') {
        user = linha['idUser'];
        print(user);
      }else{
        user = 0;
      }
    });
    return user;
  } else {
    throw const Text('Error has ocurred: $e');
  }
}
//obtain user's name to later display it
Future<String> fetchUserName() async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    apiroute +'/user/encontra',
  );
  var response = await http.get(
    url,
    headers: <String, String>{
      'authorization': 'Bearer $storedToken',
    },
  );
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    String _token = storedToken.toString();
    String user = '';
    var lista = jsonDecode(response.body)['data'];

    lista.forEach((linha) {
      if (linha['name'].toString()!= 'null') {
        user = linha['name'].toString();
        print(user);
      }else{
        user = 'não atribuido';
      }
    });
    print(user);
    return user;
  } else {
    throw const Text('Error has ocurred: $e');
  }
}

//obtain user's email to later display it
Future<String> fetchUserEmail() async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    apiroute +'/user/encontra',
  );

  var response = await http.get(
    url,
    headers: <String, String>{
      'authorization': 'Bearer $storedToken',
    },
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    String _token = storedToken.toString();
    String user = '';
    var lista = jsonDecode(response.body)['data'];
    lista.forEach((linha) {
      if (linha['email'].toString()!= 'null') {
        user = linha['email'].toString();
        print(user);
        
      }else{
        user = 'não atribuido';
      }
    });
    return user;
  } else {
    throw const Text('Error has ocurred: $e');
  }
}

//obtain user's phone to later display it
Future<String> fetchUserPhone() async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    apiroute +'/user/encontra',
  );

  var response = await http.get(
    url,
    headers: <String, String>{
      'authorization': 'Bearer $storedToken',
    },
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    String _token = storedToken.toString();
    String user = '';
    var lista = jsonDecode(response.body)['data'];

    lista.forEach((linha) {
      if (linha['phone'].toString()!= 'null') {
        user = linha['phone'].toString();
        
      }else{
        user = 'não atribuido';
      }
      print(user);
    });
    return user;
  } else {
    throw const Text('Error has ocurred: $e');
  }
}

//obtain user's address to later display it
Future<String> fetchUserAddress() async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    apiroute +'/user/encontra',
  );

  var response = await http.get(
    url,
    headers: <String, String>{
      'authorization': 'Bearer $storedToken',
    },
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    String _token = storedToken.toString();


    String user = '';
    var lista = jsonDecode(response.body)['data'];

    lista.forEach((linha) {
      print(linha);
      if (linha['address'].toString()!= 'null') {
        user = linha['address'].toString();
      }else{
        user = 'não atribuido';
      }
      
      print(user);
    });
    return user;
  } else {
    throw const Text('Error has ocurred: $e');
  }
}

//obtain user's driver to later display it
Future<String> fetchUserDriver() async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    apiroute +'/user/encontra',
  );

  var response = await http.get(
    url,
    headers: <String, String>{
      'authorization': 'Bearer $storedToken',
    },
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    String _token = storedToken.toString();


    String user = '';
    bool driver = false;
    var lista = jsonDecode(response.body)['data'];

    lista.forEach((linha) {
      if (linha['driver'].toString()!= 'null') {
        driver = linha['driver'];
        if (driver == true) {
          user = 'Possui';
        } else if (driver == false) {
          user = 'Não Possui';
        } else {
          user = 'Desconhecido';
        }
        if (driver == Null) {
          driver = false;
        }
        print(user);
        
      }else{
        user = 'não atribuida';
      }
    });
    return user;
  } else {
    throw const Text('Error has ocurred: $e');
  }
}

//obtain user's img to later display it
Future<String> fetchUserImg() async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    apiroute +'/user/encontra',
  );

  var response = await http.get(
    url,
    headers: <String, String>{
      'authorization': 'Bearer $storedToken',
    },
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    String _token = storedToken.toString();


    String user = '';
    var lista = jsonDecode(response.body)['data'];

    lista.forEach((linha) {
      if (linha['imgPath'].toString()!= 'null') {
        user = linha['imgPath'].toString();
        
      }else{
        user = 'não atribuido';
      }
      print(user);
    });
    return user;
  } else {
    throw const Text('Error has ocurred: $e');
  }
}

//obtain user's profile to later display it
Future<String> fetchUserProfile() async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    apiroute+'/user/encontra',
  );

  var response = await http.get( 
    url,
    headers: <String, String>{
      'authorization': 'Bearer $storedToken',
    },
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    print(data);
    String _token = storedToken.toString();
    String user = '';
    var lista = jsonDecode(response.body)['data'];

    lista.forEach((linha) {
      print(linha['profileUser']);
      if (linha['profileUser'].toString()!= 'null') {
        user = linha['profileUser'].toString();
        if (user == '1') {
          user = 'Colaborador';
        }else if(user == '2'){
          user= 'Manager';
        }else if(user == '0'){
          user = 'Administrador';
        }
      }else{
        user = 'não atribuido';
      }
      print(user);
    });
    return user;
  } else {
    throw const Text('Error has ocurred: $e');
  }
}

//obtain user's status to later display it
Future<String> fetchUserStatus() async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    apiroute+'/user/encontra',
  );

  var response = await http.get( 
    url,
    headers: <String, String>{
      'authorization': 'Bearer $storedToken',
    },
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    print(data);
    String _token = storedToken.toString();


    String user = '';
    var lista = jsonDecode(response.body)['data'];

    lista.forEach((linha) {
      if (linha['statusUser'].toString()!= 'null') {
        user = linha['statusUser'].toString();
        if (user == '1') {
          user = 'email não verificado';
        }else if(user == '2'){
          user= 'aprovado';
        }else if(user == '3'){
          user = 'não aprovado';
        }
      }else{
        user = 'não atribuido';
      }
      print(user);
    });
    return user;
  } else {
    throw const Text('Error has ocurred: $e');
  }
}


//PUT
Future<void> updateUserName(name, email, phone, address, driver) async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    apiroute + '/user/update',
  );

  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $storedToken',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'driver': driver,
        'profileUser': 1
      }));

  if (response.statusCode == 200) {
    print('Data Updated');
  } else {
    throw const Text('Error has ocurred: $e');
  }
}

Future<void> changeUserPassword(password, newPassword, confirmNewPassword) async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    apiroute +'/user/changePassword',
  );

  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $storedToken',
      },
      body: jsonEncode({
        'actualPassword':password,
        'newPassword':newPassword,
        'confirmNewPassword':confirmNewPassword
      }));

  if (response.statusCode == 200) {
    print('Data Updated');
  } else {
    throw const Text('Error has ocurred: $e');
  }
}

