import 'package:adm23194/class.global.dart';
import 'package:adm23194/components/items.wide.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';  // Importa o pacote de widgets de calendário
import 'package:intl/date_symbol_data_local.dart';  // Importa o pacote para inicializar dados de localização de datas
import 'package:adm23194/server/server.event.dart' as a;
class ScreenTime extends StatefulWidget {
  const ScreenTime({super.key});

  @override
  State<ScreenTime> createState() => _Page();
}


class _Page extends State<ScreenTime> {
  
  String calendarEvent = '';
  CalendarFormat _calendarFormat = CalendarFormat.month;  // Declara uma variável para o formato do calendário
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<MeetingEvent>> _events = {};
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Inicializa os dados de localização para Português (Portugal)
    initializeDateFormatting('pt_PT');
  }

  Widget build(BuildContext context) {  // Sobrescreve o método build para construir a interface do usuário
    return Scaffold(  // Retorna um widget de Scaffold
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Text(
                  textAlign: TextAlign.start,
                  "Submissão de horas",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor[0]
                  )
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  textAlign: TextAlign.start,
                  "Razão para o pedido",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                ),
                const SizedBox(  // SizedBox
                  height: 10,  // Define a altura como 10
                ),
                 // SizedBox
                //converter em uma dropbox
                SizedBox(  // Retorna um widget de SizedBox com altura definida
                  height: 120,  // Define a altura como 120
                  child: TextField(  // Retorna um widget de TextField para entrada de texto
                    controller: titleController,  // Define o controlador de texto para o TextField
                    textAlignVertical: TextAlignVertical.top,  // Define o alinhamento vertical do texto como top
                    maxLines: null,  // Permite um número indefinido de linhas
                    expands: true,  // Permite que o TextField expanda verticalmente
                    decoration: const InputDecoration(  // Define a decoração do TextField
                      enabledBorder: OutlineInputBorder(),  // Borda quando o TextField não está focado
                      labelText: "Escreva a sua razão...",  // Rótulo do TextField
                      focusedBorder: OutlineInputBorder(),  // Borda quando o TextField está focado
                    ),
                  ),
                ),  // SizedBox
                const SizedBox(  // SizedBox
                  height: 25,  // Define a altura como 25
                ),  // SizedBox
                const Text(  // Text
                    textAlign: TextAlign.start,  // Define o alinhamento do texto como start
                    "Escolha a data desejada",  // Texto a ser exibido
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),  // Define o estilo do texto
                const SizedBox(  // SizedBox
                  height: 5,  // Define a altura como 5
                ),  // SizedBox
                TableCalendar(  // Retorna um widget de TableCalendar para exibir um calendário
                  selectedDayPredicate: (day) {  // Define uma função para verificar se um dia é selecionado
                    return isSameDay(_selectedDay, day);  // Retorna verdadeiro se o dia for o selecionado
                  },  // selectedDayPredicate
                  onDaySelected: (selectedDay, focusedDay) {  // Define uma função para lidar com a seleção de um dia
                    setState(() {  // Atualiza o estado do widget
                      _selectedDay = selectedDay;  // Define o dia selecionado
                      _focusedDay = focusedDay;  // Define o dia focado
                    });
                  },  // onDaySelected
                  firstDay: DateTime.utc(2023, 01, 20),  // Define o primeiro dia do calendário
                  lastDay: DateTime.utc(2030, 3, 14),  // Define o último dia do calendário
                  focusedDay: DateTime.now(),  // Define o dia focalizado como o dia atual
                  locale: 'pt_PT',  // Define a localização do calendário como Português (Portugal)
                  calendarFormat: _calendarFormat,  // Define o formato do calendário
                  onFormatChanged: (format) {  // Define uma função para lidar com a mudança de formato do calendário
                    setState(() {  // Atualiza o estado do widget
                      _calendarFormat = format;  // Define o formato do calendário
                    });
                  },  // onFormatChanged
                  onPageChanged: (focusedDay) {  // Define uma função para lidar com a mudança de página do calendário
                    _focusedDay = focusedDay;  // Define o dia focalizado
                  },
                ),  // TableCalendar
                _selectedDay != null  // Verifica se um dia foi selecionado
                    ? _buildEventPanel(_selectedDay!)  // Chama a função para construir o painel de eventos
                    : const SizedBox(),  // SizedBox
              ],
            ),
          ),
        ),
      ),
    );
  }  // build

//eventos
  Widget _buildEventPanel(DateTime selectedDay) {  // Define uma função para construir o painel de eventos
    return ExpansionPanelList(  // Retorna um widget de ExpansionPanelList para exibir uma lista de painéis expansíveis
      elevation: 1,  // Define a elevação do painel
      expandedHeaderPadding: const EdgeInsets.all(0),  // Define o preenchimento expandido do cabeçalho
      expansionCallback: (int index, bool isExpanded) {  // Define uma função de retorno de chamada para a expansão do painel
        setState(() {  // Atualiza o estado do widget
          // Alterna o estado do painel de expansão
        });
      },  // expansionCallback
      children: [  // Lista de widgets filhos
        ExpansionPanel(  // Retorna um widget de ExpansionPanel para exibir um painel expansível
          headerBuilder: (BuildContext context, bool isExpanded) {  // Define uma função para construir o cabeçalho do painel
            return ListTile(  // Retorna um widget de ListTile para exibir o cabeçalho do painel
              title: Text("Eventos para o dia ${selectedDay.toLocal()}"),  // Define o título do ListTile
            );
          },  // headerBuilder
          body: _buildEventList(selectedDay),  // Define o corpo do painel como a lista de eventos
          isExpanded: true,  // Define se o painel está expandido
        ),
      ],
    );
  }  // _buildEventPanel

//listar eventos + adicionar
  Widget _buildEventList(DateTime selectedDay) {  // Define uma função para construir a lista de eventos
    // Recupera os eventos para o dia selecionado do mapa de eventos
    List<MeetingEvent> events = _events[selectedDay] ?? [];  // Inicializa uma lista de eventos

    return Column(  // Retorna um widget de Column para organizar a lista de eventos
      children: [  // Lista de widgets filhos
        // Exibe a lista de eventos
        for (var event in events) _buildEventItem(event),  // Constroi um item de evento para cada evento na lista
        const SizedBox(height: 10),  // Retorna um widget de SizedBox com altura fixa
        // Botão para adicionar evento
        ElevatedButton(  // Retorna um botão elevado para adicionar um evento
          onPressed: () {  // Define uma função para lidar com o clique no botão
            _showAddEventDialog(selectedDay);  // Mostra o diálogo para adicionar um evento
          },
          child: const Text("Adicionar evento"),  // Define o texto do botão
        ),
      ],
    );
  }  // _buildEventList

  Widget _buildEventItem(MeetingEvent event) {  // Define uma função para construir um item de evento
    return ListTile(  // Retorna um widget de ListTile para exibir informações sobre o evento
      title: Text(event.title),  // Define o título do evento
      subtitle: Text("${event.startTime} - ${event.endTime}"),  // Define o subtítulo do evento
    );
  }  // _buildEventItem

  Future<void> _showAddEventDialog(DateTime selectedDay) async {  // Define uma função para exibir o diálogo para adicionar um evento
    TextEditingController startTimeController = TextEditingController();  // Controlador de texto para a hora de início
    TextEditingController endTimeController = TextEditingController();  // Controlador de texto para a hora de término

    await showDialog(  // Exibe um diálogo assíncrono
      context: context,  // Contexto do diálogo
      builder: (BuildContext context) {  // Define uma função para construir o conteúdo do diálogo
        return AlertDialog(  // Retorna um widget de AlertDialog para exibir um diálogo
          title: const Text('Adicionar Evento'),  // Define o título do diálogo
          content: Column(  // Retorna um widget de Column para organizar o conteúdo do diálogo
            children: [
              TextField(  // Retorna um widget de TextField para inserir a hora de início do evento
                controller: startTimeController,  // Define o controlador de texto
                decoration: const InputDecoration(  // Define a decoração do TextField
                  labelText: 'Hora de ínicio',  // Rótulo do TextField
                  hintText: '00:00:00',  // Texto de sugestão
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: false),  // Define o tipo de teclado
              ),
              TextField(  // Retorna um widget de TextField para inserir a hora de término do evento
                controller: endTimeController,  // Define o controlador de texto
                decoration: const InputDecoration(  // Define a decoração do TextField
                  labelText: 'Hora de fim',  // Rótulo do TextField
                  hintText: '00:00:00',  // Texto de sugestão
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: false),  // Define o tipo de teclado
              ),
            ],
          ),
          actions: [  // Lista de ações do diálogo
            TextButton(  // Retorna um botão de texto para cancelar
              onPressed: () {  // Define uma função para lidar com o clique no botão
                Navigator.pop(context);  // Fecha o diálogo
              },
              child: Text('Cancel'),  // Define o texto do botão
            ),
            TextButton(  // Retorna um botão de texto para adicionar o evento
              onPressed: () {  // Define uma função para lidar com o clique no botão
                // Adiciona o evento ao mapa de eventos
                MeetingEvent newEvent = MeetingEvent(  // Cria um novo evento
                  title: titleController.text,  // Define o título do evento
                  startTime: startTimeController.text,  // Define a hora de início do evento
                  endTime: endTimeController.text,  // Define a hora de término do evento
                );
                print(newEvent);  // Exibe o novo evento no console
                // Verifica se já existem eventos para o dia selecionado
                if (_events.containsKey(selectedDay)) {  // Verifica se o dia já está no mapa de eventos
                  _events[selectedDay]!.add(newEvent);  // Adiciona o evento à lista de eventos
                } else {  // Se o dia não estiver no mapa de eventos
                  _events[selectedDay] = [newEvent];  // Cria uma nova lista de eventos para o dia
                }
                Navigator.pop(context);  // Fecha o diálogo
                setState(() {});  // Atualiza o estado do widget para refletir as alterações
              },
              child: const Text('Adicionar'),  // Define o texto do botão
            ),
          ],
        );
      },
    );
  }  // _showAddEventDialog
}  // _Page

class MeetingEvent {  // Define uma classe para representar um evento de reunião
  final String title;  // Título do evento
  final String startTime;  // Hora de início do evento
  final String endTime;  // Hora de término do evento

  MeetingEvent({  // Construtor da classe MeetingEvent
    required this.title,  // Parâmetro obrigatório para o título do evento
    required this.startTime,  // Parâmetro obrigatório para a hora de início do evento
    required this.endTime,  // Parâmetro obrigatório para a hora de término do evento
  });
}  // MeetingEvent
