import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'class.global.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'components/items.wide.dart';
import 'server/server.event.dart' as s;

class ScreenMeetingEvents extends StatefulWidget {
  const ScreenMeetingEvents({Key? key}) : super(key: key);

  @override
  State<ScreenMeetingEvents> createState() => _Page();
}

class _Page extends State<ScreenMeetingEvents> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<MeetingEvent>> _events = {};
  TextEditingController titleController = TextEditingController();
  List<String> listStat = <String>['One', 'Two', 'Three', 'Four'];

  @override
  void initState() {
    super.initState();
    // Initialize locale data for Portuguese (Portugal)
    initializeDateFormatting('pt_PT');
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor[0],
          iconTheme: const IconThemeData(color: AppColors.colorBlack),
          title: Text(Vars.routePortalMeeting,
              style: TextStyle(color: AppColors.primaryColor[1]))
          //title: Text(widget.title)
          ),
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
                  "Solicitação de reunião",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors
                        .primaryColor[0], // Change to your desired color
                  ),
                ),
                const Text(
                  "com Gestor de Recursos Humanos",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Razão para a solicitação",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    labelText: "Escreva a sua razão...",
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  "Escolha a data desejada",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TableCalendar(
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  firstDay: DateTime.utc(2023, 01, 20),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  locale: 'pt_PT',
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                _selectedDay != null
                    ? _buildEventPanel(_selectedDay!)
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

//eventos
  Widget _buildEventPanel(DateTime selectedDay) {
    return ExpansionPanelList(
      elevation: 1,
      expandedHeaderPadding: const EdgeInsets.all(0),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          // Toggle the state of the expansion panel
        });
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text("Eventos para o dia ${selectedDay.toLocal()}"),
            );
          },
          body: _buildEventList(selectedDay),
          isExpanded: true,
        ),
      ],
    );
  }

//listar eventos + adicionar
  Widget _buildEventList(DateTime selectedDay) {
    // Retrieve events for the selected day from the _events map
    List<MeetingEvent> events = _events[selectedDay] ?? [];

    return Column(
      children: [
        // Display the list of events
        for (var event in events) _buildEventItem(event),
        const SizedBox(height: 10),
        // Add event button
        ElevatedButton(
          onPressed: () {
            _showAddEventDialog(selectedDay);
          },
          child: const Text("Adicionar evento"),
        ),
      ],
    );
  }

  Widget _buildEventItem(MeetingEvent event) {
    return ListTile(
      title: Text(event.title),
      subtitle: Text("${event.startTime} - ${event.endTime}"),
    );
  }

  Future<void> _showAddEventDialog(DateTime selectedDay) async {
    String dropdownValue = listStat.first;
    TextEditingController startTimeController = TextEditingController();
    TextEditingController endTimeController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Evento'),
          content: Column(
            children: [
              TextField(
                controller: startTimeController,
                decoration: const InputDecoration(
                  labelText: 'Hora de ínicio',
                  hintText: '00:00:00',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
              ),
              TextField(
                controller: endTimeController,
                decoration: const InputDecoration(
                  labelText: 'Hora de fim',
                  hintText: '00:00:00',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
              ),
              DropdownMenu<String>(
                initialSelection: listStat.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    listStat.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              )
              //adicionar o resto que for necessário
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add the event to the _events map
                MeetingEvent newEvent = MeetingEvent(
                  title: titleController.text,
                  startTime: startTimeController.text,
                  endTime: endTimeController.text,
                );

                // Check if there are already events for the selected day
                if (_events.containsKey(selectedDay)) {
                  _events[selectedDay]!.add(newEvent);
                } else {
                  _events[selectedDay] = [newEvent];
                }

                // Close the dialog
                Navigator.pop(context);

                // Call setState to update the UI
                setState(() {});
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}

class MeetingEvent {
  final String title;
  final String startTime;
  final String endTime;

  MeetingEvent({
    required this.title,
    required this.startTime,
    required this.endTime,
  });
}
