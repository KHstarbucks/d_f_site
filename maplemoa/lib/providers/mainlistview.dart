import 'package:flutter/material.dart';

class MyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('아이템 1'),
        ),
        ListTile(
          title: Text('아이템 2'),
        ),
        ListTile(
          title: Text('아이템 3'),
        ),
        ListTile(
          title: Text('아이템 4'),
        ),
        ListTile(
          title: Text('아이템 5'),
        ),
        // 여러 다양한 위젯들을 추가할 수 있습니다.
      ],
    );
  }
}
