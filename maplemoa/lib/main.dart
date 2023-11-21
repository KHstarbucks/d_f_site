import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/board_page.dart';
import 'pages/login_page.dart';
import 'pages/calculator_page.dart';
import 'pages/union_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:community/providers/navigationbar.dart';
import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter());

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
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
  bool isLoggedIn = false;

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: <Widget> [
            Scaffold(
              body: Center(
                child: isLoggedIn ?
                _widgetOptions.elementAt(currentIndex)
                : LoginPage(onLoginSuccess: (){
                  setState(() {
                    isLoggedIn = true;
                  });
                })
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

