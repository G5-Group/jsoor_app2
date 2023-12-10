//**************************************************************************

//-------------- HomeScreen ----------------
import 'package:flutter/material.dart';
import 'package:jsoor_app2/ThemeProvider.dart';
import 'package:jsoor_app2/machine_learning/analysis_view.dart';
import 'package:jsoor_app2/screens/translate_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkModeEnabled = themeProvider.isDarkModeEnabled;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDarkModeEnabled ? const Color(303030) : const Color(0xFF136a8d),
        //title: Text('Home'),
      ),
      body: Container(
        color:
            isDarkModeEnabled ? const Color(131313) : const Color(0xFF8cc7e6),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/Jsoor.png', // Replace with your image path
                width: 300,
                height: 300,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AnalysisPage()),
                  );
                },
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(
                          'images/sing languge.jpg'), // Replace with your image path
                      radius: 40,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!.translateButton,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
