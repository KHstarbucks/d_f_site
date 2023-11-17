import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/board_page.dart';
import 'pages/login_page.dart';
import 'pages/calculator_page.dart';
import 'pages/union_page.dart';

import 'package:community/providers/navigationbar.dart';

void main() async {
   // android and ios
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget{
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyStatefulWidgetState();
    // TODO: implement createState
}

class MyStatefulWidgetState extends State<MyStatefulWidget>{
  final PageController _pageController = PageController();

  int currentIndex = 0;

  final List<Widget> _widgetOptions = <Widget> [
    HomePage(),
    BoardPage(),
    UnionWidget(),
    CalculatorWidget(),
  ];

  @override
  void dispose(){
    _pageController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('메이플모아',
            style: TextStyle(
              fontSize:18,
            )
          ),
          backgroundColor:const Color(0xffEE8B60),
        ),
        body: PageView(
          controller: _pageController,
          children: <Widget> [
            Scaffold(
              body: Center(
                child: _widgetOptions.elementAt(currentIndex),
              ),
              bottomNavigationBar: MyNavigationBar(
                currentIndex: currentIndex,
                onItemTapped: (index) {
                  setState(() {
                  currentIndex = index;
                });
                }
              ),
              ),
            ])
          
        )
      );
    
  }
}

