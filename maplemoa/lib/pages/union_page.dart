import 'package:flutter/material.dart';

class UnionPage extends StatefulWidget{
  const UnionPage({Key ? key}) : super(key:key);
  @override
  State<UnionPage> createState() => _UnionPageState();
}

class _UnionPageState extends State<UnionPage>{
  //레벨
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: const Text('유니온 배치',
            style: TextStyle(
              fontSize:18,
            )
          ),
          backgroundColor:const Color(0xffEE8B60),
        ),
      
    );
  }
}