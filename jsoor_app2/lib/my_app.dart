//****************************************************************************

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:jsoor_app2/ThemeProvider.dart';
import 'package:jsoor_app2/screens/group_screen.dart';
import 'package:jsoor_app2/screens/home_page.dart';
import 'package:jsoor_app2/screens/setting_screen.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const GroupsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkModeEnabled = themeProvider.isDarkModeEnabled;
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _pageIndex != 2,
            child: TickerMode(
              enabled: _pageIndex == 2,
              child: _pages[2],
            ),
          ),
          Offstage(
            offstage: _pageIndex == 2,
            child: Scaffold(
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: isDarkModeEnabled
                    ? const Color(131313)
                    : const Color(0xFF8cc7e6),
                color: isDarkModeEnabled
                    ? const Color(303030)
                    : const Color(0xFF136a8d),
                animationDuration: const Duration(milliseconds: 300),
                index: _pageIndex,
                onTap: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                items: const [
                  Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.groups,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                ],
              ),
              body: _pages[_pageIndex],
            ),
          ),
        ],
      ),
    );
  }
}
