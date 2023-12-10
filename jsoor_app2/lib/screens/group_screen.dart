//**************************************************************************
// about us (class 4)
//----------- GroupsScreen ---------------

import 'package:flutter/material.dart';
import 'package:jsoor_app2/ThemeProvider.dart';
import 'package:jsoor_app2/widgets/frosted_glass_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkModeEnabled = themeProvider.isDarkModeEnabled;

    return Scaffold(
      backgroundColor: isDarkModeEnabled ? Color(131313) : Color(0xFF8cc7e6),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.aboutUs),
        backgroundColor: isDarkModeEnabled ? Color(303030) : Color(0xFF136a8d),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/Jsoor.png',
              width: 300,
              height: 200,
            ),
            const SizedBox(height: 40),
            FrostedGlassBox(
              theWidth: 350.toDouble(),
              theHeight: 200.toDouble(),
              theChild: Text(
                AppLocalizations.of(context)!.jsoor,
                style: TextStyle(fontSize: 24, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
