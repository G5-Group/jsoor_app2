//**************************************************************************
// Settings (class 5)
//------------SettingsScreen------------------
import 'package:flutter/material.dart';
import 'package:jsoor_app2/ThemeProvider.dart';
import 'package:jsoor_app2/main.dart';
import 'package:jsoor_app2/my_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  String selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('selectedLanguage') ?? 'English';
    });
  }

  Future<void> _saveSelectedLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkModeEnabled = themeProvider.isDarkModeEnabled;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        backgroundColor: isDarkModeEnabled ? Color(303030) : Color(0xFF136a8d),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
        ),
      ),
      body: Container(
        color: isDarkModeEnabled ? Color(131313) : Color(0xFF8cc7e6),
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            ListTile(
              leading: Icon(Icons.volume_up),
              iconColor: Color(0xFF136a8d),
              title: Text(
                AppLocalizations.of(context)!.voice,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(AppLocalizations.of(context)!.pronunciationSpeed),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                // Navigate to voice settings page
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.accessibility),
              iconColor: Color(0xFF136a8d),
              title: SwitchListTile(
                title: Text(
                  AppLocalizations.of(context)!.accessibility,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(AppLocalizations.of(context)!.screenMode),
                value: isDarkModeEnabled,
                onChanged: (value) {
                  // Toggle the theme mode and save the selection
                  themeProvider.toggleTheme();
                },
              ),
            ),
            Divider(),
            ExpansionTile(
              leading: Icon(Icons.language),
              iconColor: Color(0xFF136a8d),
              title: Text(
                AppLocalizations.of(context)!.language,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(AppLocalizations.of(context)!.selectLanguage),
              trailing: Icon(Icons.keyboard_arrow_down),
              children: [
                RadioListTile(
                  title: Text('English'),
                  value: 'English',
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value!;
                      _saveSelectedLanguage(value);
                      MyApp.setLocale(context, Locale('en'));
                    });
                  },
                ),
                RadioListTile(
                  title: Text('عربي'),
                  value: 'عربي',
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value!;
                      _saveSelectedLanguage(value);
                      MyApp.setLocale(context, Locale('ar'));
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
