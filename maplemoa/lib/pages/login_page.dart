import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authentication = FirebaseAuth.instance;


  bool isLoginPage = true;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';

  void _tryValidation(){
    final isValid = _formKey.currentState!.validate();

    if(isValid){
      _formKey.currentState!.save();
    }
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF8F1EB),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right:0,
              left: 0,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffEE8b60)],
                    stops: [0,1],
                    begin: AlignmentDirectional(0.87,-1),
                    end: AlignmentDirectional(-0.87,1),
                  ),
                ),
                alignment: AlignmentDirectional(0.00,-1.00),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 32),
                        child: Container(
                          width: 200,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: AlignmentDirectional(0.00,0.00),
                          child: Text(
                            '메이플모아',
                            style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize:32,
                              color:Colors.white
                            ),
                          )
                        )
                        )
                    ],
                  ),
                )
              ),
            )
          ],
        )
      )
    );
  }
}