import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'autoRouter.gr.dart';

class RouterApp extends StatefulWidget {
  @override
  State<RouterApp> createState() => _RouterAppState();

}

class _RouterAppState extends State<RouterApp> {
  final _appRouter = AppRouter();
  bool hideNavbar = false;
  int _currentIndex = 0;
  final List<String> _children = [
    '/',
    '/search',
    '/profile',
  ];

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
        _appRouter.replaceNamed(_children[index]);
      });
    }
    return Scaffold(
      body: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
      bottomNavigationBar: hideNavbar == false
      ? BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.indigo[100],
        selectedIconTheme:
        IconThemeData(color: Colors.indigo, size: 40),
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ): null,
    );
  }
}