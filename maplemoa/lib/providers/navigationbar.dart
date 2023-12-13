import 'package:flutter/material.dart';

class MyNavigationBar extends StatelessWidget{

  final int currentIndex;
  final Function(int) onItemTapped;
  
  const MyNavigationBar({super.key,  required this.currentIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context){
    return Material(
      elevation: 8,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note_outlined),
            label: '게시판', 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: '캐릭정보',
          ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate_outlined),
              label: '환산',
          ),
        ],
        selectedItemColor:const Color(0xffee8b60),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,     
      )
    );
  }
}