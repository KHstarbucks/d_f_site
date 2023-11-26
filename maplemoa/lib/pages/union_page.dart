import 'package:flutter/material.dart';

class UnionPage extends StatelessWidget{
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
      body: Center(
        child: const Text(
          'Union',
          style: TextStyle(
            color: Colors.black,
            fontSize:20,
          )
      ))
    );
  }
}