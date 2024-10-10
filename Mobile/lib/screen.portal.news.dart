import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:adm23194/server/server.meeting.dart';
import 'package:adm23194/class.global.dart';
import './components/card.dart';

class ScreenNews extends StatefulWidget {
  const ScreenNews({super.key});

  @override
  State<ScreenNews> createState() => _Page();
}

String url= Vars.apiRoute+"/news";

class _Page extends State<ScreenNews> {

  Map<String, dynamic> items = {};

  @override
  void initState() {
    super.initState();
    fetchItems(); // Chama a função para buscar os itens
  }

  Future<List<Map<String, dynamic>>> fetchItems() async {
    List<Map<String, dynamic>> fetchedItems = await ListItems(url);//* Chama a função para buscar os itens
    return fetchedItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchItems(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Text('Erro ao carregar as noticias');
          }
          
          if(snapshot.connectionState == ConnectionState.waiting)
          {
            return Center(child: const CircularProgressIndicator());
          }

          if(snapshot.hasData && snapshot.data!.isNotEmpty)
          {
            print("dentro do snap ${snapshot.data}");
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return ElevatedCardExample(
                  title: snapshot.data![index]['tittle'],
                  description:snapshot.data![index]['text']
                  
                );
              } ,
            );
          }

          return const Text('Nenhuma noticia disponivel');
        }
        ),
      ) ;
  }
}