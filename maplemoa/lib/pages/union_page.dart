import 'package:flutter/material.dart';

class UnionWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
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