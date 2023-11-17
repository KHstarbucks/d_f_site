import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:community/providers/boards.dart';


class BoardPage extends StatefulWidget{
  const BoardPage({Key? key}) : super(key:key);

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: const Text('자유 게시판',
            style: TextStyle(
              fontSize:18,
            )
          ),
          backgroundColor: const Color(0xffEE8B60),
        ),
    );
  }
}