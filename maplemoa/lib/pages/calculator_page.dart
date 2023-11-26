import'package:flutter/material.dart';

class CalculatorPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: const Text('환산 계산기',
            style: TextStyle(
              fontSize:18,
            )
          ),
          backgroundColor:const Color(0xffEE8B60),
        ),
      body: Center(
        child: const Text(
          'Calculator',
          style: TextStyle(
            color: Colors.black,
            fontSize:20,
          )
      ))
    );
  }
}

