import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Title',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('메이플모아')
      ),
      drawer: MenuDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          switch (index){
            case 0:
              Navigator.pushNamed(context, '/');
              break;
            case 1:
              Navigator.pushNamed(context, '/board');
              break;
            case 2:
              Navigator.pushNamed(context, '/union');
              break;
            case 3:
              Navigator.pushNamed(context, '/calc');
              break;
            default:


          }
        },
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home), label:'home'),
          BottomNavigationBarItem(icon: Icon(Icons.megaphone), label:'board'),
          BottomNavigationBarItem(icon: Icon(Icons.union), label:'union'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'calc')
        ],

      ),
      )
    )
  }
}