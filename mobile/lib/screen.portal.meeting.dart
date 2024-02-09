import 'package:adm23194/screen.portal.meeting.events.dart';
import 'package:flutter/material.dart';
import 'class.global.dart';
import 'components/items.wide.dart';

class ScreenMeeting extends StatefulWidget {
  const ScreenMeeting({Key? key}) : super(key: key);

  @override
  State<ScreenMeeting> createState() => _Page();
}

class _Page extends State<ScreenMeeting> {
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
                const Text(
                  "Próximas reuniões",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Items_Wide(
                  title1: 'com Manager',
                  icon: Icons.calendar_month,
                  title2: '28/11/2023',
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Deseja marcar uma reunião?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        width: 5,
                        color: AppColors
                            .primaryColor[0], // Change to your desired color
                      ),
                    ),
                  ),
                  child: const Text(
                    "No caso de se interessar a marcar uma reunião com o seu gestor(a) de recursos humanos, \naceda o formulário através do botão seguinte e preencha a informação necessária. \nO seu gestor(a) irá ser notificado e ponderar o seu pedido.",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height:30,
                ),
                Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor[0],
                      ),
                      child: Container(
                          child: const Text(
                        "Marcar novas reuniões",
                        style: TextStyle(color: AppColors.colorWhite),
                      )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ScreenMeetingEvents()));
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
