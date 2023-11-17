import'package:flutter/material.dart';

class CalculatorWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
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

