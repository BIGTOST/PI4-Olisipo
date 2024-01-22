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

//obtain user's name to later display it
Future<String> fetchUserName() async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    apiroute +'/user',
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
    var encodedPayload = _token.split('.')[1];
    var payloadData =
        utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    print(payloadData);
    final payload = Payload.fromJson(jsonDecode(payloadData));
    print(payload.id);

    String user = "";
    var lista = jsonDecode(response.body)['data'];

    lista.forEach((linha) {
      if (linha['idUser'] == payload.id) {
        user = linha['name'].toString();
        print(user);
        if(user== null){
          user = 'não atribuido';
       }
      }
    });
    return user;
  } else {
    throw const Text('Error has ocurred: $e');
  }
}

//obtain user's email to later display it
Future<String> fetchUserEmail() async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    apiroute +'/user',
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
    var encodedPayload = _token.split('.')[1];
    var payloadData =
        utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    print(payloadData);
    final payload = Payload.fromJson(jsonDecode(payloadData));
    print(payload.id);

    String user = "";
    var lista = jsonDecode(response.body)['data'];

    lista.forEach((linha) {
      if (linha['idUser'] == payload.id) {
        user = linha['email'].toString();
        print(user);
        if(user== null){
          user = 'não atribuido';
       }
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
    apiroute +'/user',
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
    var encodedPayload = _token.split('.')[1];
    var payloadData =
        utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    print(payloadData);
    final payload = Payload.fromJson(jsonDecode(payloadData));
    print(payload.id);

    String user = "";
    var lista = jsonDecode(response.body)['data'];

    lista.forEach((linha) {
      if (linha['idUser'] == payload.id) {
        user = linha['phone'].toString();
        print(user);
        if(user== null){
          user = 'não atribuido';
       }
      }
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
    apiroute +'/user',
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
    var encodedPayload = _token.split('.')[1];
    var payloadData =
        utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    print(payloadData);
    final payload = Payload.fromJson(jsonDecode(payloadData));
    print(payload.id);

    String user = "";
    var lista = jsonDecode(response.body)['data'];

    lista.forEach((linha) {
      if (linha['idUser'] == payload.id) {
        user = linha['address'].toString();
        if (user == Null) { //tentar hasData
          user = "Desconhecido";
        }
        print(user);
        if(user== null){
          user = 'não atribuido';
       }
      }
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
    apiroute +'/user',
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
    var encodedPayload = _token.split('.')[1];
    var payloadData =
        utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    print(payloadData);
    final payload = Payload.fromJson(jsonDecode(payloadData));
    print(payload.id);

    String user = "";
    bool driver = false;
    var lista = jsonDecode(response.body)['data'];

    lista.forEach((linha) {
      if (linha['idUser'] == payload.id && linha['driver'] != null) {
        driver = linha['driver'];
        if (driver == true) {
          user = "Possui";
        } else if (driver == false) {
          user = "Não Possui";
        } else {
          user = "Desconhecido";
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

//obtain user's driver to later display it
// Future<bool> fetchUserDriverValue() async {
//   String? storedToken = await storage.read(key: 'token');
//   var url = Uri.parse(
//     apiroute +'/user',
//   );

//   var response = await http.get(
//     url,
//     headers: <String, String>{
//       'authorization': 'Bearer $storedToken',
//     },
//   );

//   if (response.statusCode == 200) {
//     var data = json.decode(response.body);
//     String _token = storedToken.toString();
//     var encodedPayload = _token.split('.')[1];
//     var payloadData =
//         utf8.fuse(base64).decode(base64.normalize(encodedPayload));
//     print(payloadData);
//     final payload = Payload.fromJson(jsonDecode(payloadData));
//     print(payload.id);

//     bool user = false;
//     var lista = jsonDecode(response.body)['data'];

//     lista.forEach((linha) {
//       if (linha['idUser'] == payload.id) {
//         user = linha['driver'];
//         print(user);
//       }
//     });
//     return user;
//   } else {
//     throw const Text('Error has ocurred: $e');
//   }
// }

//obtain user's img to later display it
Future<String> fetchUserImg() async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    apiroute +'/user',
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
    var encodedPayload = _token.split('.')[1];
    var payloadData =
        utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    print(payloadData);
    final payload = Payload.fromJson(jsonDecode(payloadData));
    print(payload.id);

    String user = "";
    var lista = jsonDecode(response.body)['data'];

    lista.forEach((linha) {
      if (linha['idUser'] == payload.id) {
        user = linha['imgPath'].toString();
        print(user);
         if(user== null){
          user = 'não atribuido';
       }
      }
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
    'mktiagoandre.ddns.net:8080/user',
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
    var encodedPayload = _token.split('.')[1];
    var payloadData =
        utf8.fuse(base64).decode(base64.normalize(encodedPayload));
    print(payloadData);
    final payload = Payload.fromJson(jsonDecode(payloadData));
    print(payload.id);

    String user = "";
    var lista = jsonDecode(response.body)['data'];

    lista.forEach((linha) {
      if (linha['idUser'] == payload.id && linha['profileUser'] != null) {
        user = linha['profileUser'].toString();
        if (user == "1") {
          user = "Colaborador";
        }
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

//PUT

//obtain user's name to later display it
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
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "driver": driver,
        "profileUser": 1
      }));

  if (response.statusCode == 200) {
    print("Data Updated");
  } else {
    throw const Text('Error has ocurred: $e');
  }
}

Future<void> changeUserPassword(password, newPassword, confirmNewPassword) async {
  String? storedToken = await storage.read(key: 'token');
  var url = Uri.parse(
    Vars.apiRoute,
  );

  var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': 'Bearer $storedToken',
      },
      body: jsonEncode({
        "actualPassword":password,
        "newPassword":newPassword,
        "confirmNewPassword":confirmNewPassword
      }));

  if (response.statusCode == 200) {
    print("Data Updated");
  } else {
    throw const Text('Error has ocurred: $e');
  }
}

