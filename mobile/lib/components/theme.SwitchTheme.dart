import 'package:adm23194/class.global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.themeProvider.dart';

class ThemeSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return Container(
            child: SwitchListTile(
              secondary: const Icon(Icons.settings),
              title: const Text('Trocar Tema'),
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ));
      },
    );
  }
}
