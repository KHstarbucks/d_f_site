import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      )
    );
  }
  List<Widget> buildMenuItems(BuildContext context){
    final List<String> menuTitles = ['Home', '게시판', '유니온', '환산'];
    List<Widget> menuItems = [];
    menuItems.add(const DrawerHeader(
      decoration: BoxDecoration(color: Colors.orange),
      child: Text(
        '선택창',
        style: TextStyle(color: Colors.white, fontSize: 24)
      ),
      ));
  }
}