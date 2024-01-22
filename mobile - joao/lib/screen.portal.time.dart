import 'package:adm23194/class.global.dart';
import 'package:adm23194/components/items.wide.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScreenTime extends StatefulWidget {
  const ScreenTime({super.key});

  @override
  State<ScreenTime> createState() => _Page();
}

class _Page extends State<ScreenTime> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<MeetingEvent>> _events = {};
  TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Pedido de horas",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor[0])),
          const SizedBox(
            height: 15,
          ),
          const Text(
              textAlign: TextAlign.start,
              "Razão para o pedido",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
           SizedBox(
            height: 120, // <-- TextField height
            child: TextField(
              controller: titleController,
              textAlignVertical: TextAlignVertical.top,
              maxLines: null,
              expands: true,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(),
                labelText: "Escreva a sua razão...",
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
              textAlign: TextAlign.start,
              "Escolha a data desejada",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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