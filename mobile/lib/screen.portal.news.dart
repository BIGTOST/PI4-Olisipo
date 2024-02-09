import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:adm23194/server/server.meeting.dart';
import 'package:adm23194/class.global.dart';

class ScreenNews extends StatefulWidget {
  const ScreenNews({super.key});

  @override
  State<ScreenNews> createState() => _Page();
}


class _Page extends State<ScreenNews> {

 List<String> items= new List.empty();

  @override
  void initState() {
    super.initState();
    fetchItems(); // Chama a função para buscar os itens
  }

  Future<void> fetchItems() async {
    List<String> fetchedItems = await ListItems(); // Chama a função para buscar os itens
    setState(() {
      items = fetchedItems;
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold();

  }
}