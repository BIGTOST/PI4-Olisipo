//routes
import 'screen.portal.expense.dart';
import 'screen.portal.meeting.dart';
import 'screen.portal.news.dart';
import 'screen.portal.time.dart';

//others

import 'package:flutter/material.dart';
import 'class.global.dart';
import 'route.homepage.dart';
import 'components/theme.SwitchTheme.dart';

//import 'components/themeNotifier.dart';
class RoutePortal extends StatefulWidget {
  const RoutePortal({super.key});

  @override
  State<RoutePortal> createState() => _Page();
}

class _Page extends State<RoutePortal> {
  bool check = false;
  // start screen
  int currentScreen = 0;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor[0],
          iconTheme: const IconThemeData(color: AppColors.colorBlack),
          title: Text(Vars.routePortalTitle,
              style: TextStyle(color: AppColors.primaryColor[1]))
          //title: Text(widget.title)
          ),
      body: <Widget>[
        homePage(),
        const ScreenNews(),
        const ScreenTime(),
        const ScreenExpense(),
        const ScreenMeeting()
      ][currentScreen],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 30, 215, 0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                )),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {},
            ),
            ThemeSwitch()
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        onDestinationSelected: (int index) {
          setState(() {
            currentScreen = index;
          });
        },
        indicatorColor: AppColors.primaryColor[0],
        selectedIndex: currentScreen,
        destinations: <Widget>[
          const NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: Vars.routeDashboard,
          ),
          const NavigationDestination(
            icon: Icon(Icons.newspaper),
            label: Vars.routePortalNews,
          ),
          NavigationDestination(
            icon: Badge(
              label: const Text('2'),
              backgroundColor: AppColors.secondaryColor[0],
              child: const Icon(Icons.more_time),
            ),
            label: Vars.routePortalTime,
          ),
          NavigationDestination(
            icon: Badge(
              label: const Text('1'),
              backgroundColor: AppColors.secondaryColor[0],
              child: const Icon(Icons.payments),
            ),
            label: Vars.routePortalExpense,
          ),
          NavigationDestination(
            icon: Badge(
                backgroundColor: AppColors.secondaryColor[0],
                child: const Icon(Icons.calendar_month)),
            label: Vars.routePortalMeeting,
          ),
        ],
      ),
    );
  }
}
