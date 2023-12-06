import 'package:community/providers/navigationbar.dart';
import 'package:flutter/material.dart';

import 'pages/board_page.dart';
import 'pages/calculator_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page_2.dart';
import 'pages/union_page.dart';

class AppState extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppStateWidget(),
    );
  }
}

class AppStateWidget extends StatefulWidget{
  const AppStateWidget({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() => AppStateWidgetState();
}

class AppStateWidgetState extends State<AppStateWidget>{
  final PageController _pageController = PageController();

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    BoardPage(),
    UnionPage(),
    CalculatorPage(),
  ];
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: PageView(
        controller: _pageController,
          children: <Widget>[
            Scaffold(
              body: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
              bottomNavigationBar: MyNavigationBar(
                currentIndex: _selectedIndex, 
                onItemTapped: _onItemTapped
              ),
            ),
          ]
      ),
    );

  }
}