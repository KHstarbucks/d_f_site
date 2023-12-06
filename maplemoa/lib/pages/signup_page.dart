import 'package:community/providers/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'login_page_2.dart';

class SignupPage extends StatelessWidget{
  final TextEditingController _NameController = TextEditingController();
  final TextEditingController _UidController = TextEditingController();
  final TextEditingController _UpwController = TextEditingController();
  final TextEditingController _UpwcheckController = TextEditingController();
  
  final Logger _logger = Logger();

  void _singUp() async {
    String uname = _NameController.text;
    String id = _UidController.text;
    String pw = _UpwController.text;
    String pwcheck = _UpwController.text;

    if(pw == pwcheck){
      try{
        //firebaseauth에 id,pw저장
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: id,
          password: pw
          );
          String uid = userCredential.user!.uid;
          //firestore에 닉네임 저장
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
            'id' : id,
            'name': uname,
          });

          _logger.i('sign up $uid');
      }on FirebaseAuthException catch(e){
        _logger.e('Sign up failed. $e');
      }
    }
    else {return;}
  }
  

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0XFFEE8B60),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                maxWidth: 570,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow:[
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0X33000000),
                    offset: Offset(0,2),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Align(
                alignment: AlignmentDirectional(0,0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
                        child: Text(
                          'create your account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _NameController,
                            autofocus: true,
                            autofillHints: [AutofillHints.name],
                            obscureText: false,
                            cursorColor: const Color(0xf8606163),
                            decoration: InputDecoration(
                              labelText: 'Nickname',
                              labelStyle: const TextStyle(color: Color(0xf8606163)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width:2,
                                  color: Color(0xfff1f2f8),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color(0xfff1f2f8),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: const Color(0xfff1f2f8),
                            ),
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _UidController,
                            autofocus: true,
                            autofillHints: [AutofillHints.email],
                            obscureText: false,
                            cursorColor: const Color(0xf8606163),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: const TextStyle(color: Color(0xf8606163)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width:2,
                                  color: Color(0xfff1f2f8),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color(0xfff1f2f8),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: const Color(0xfff1f2f8),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _UpwController,
                            autofocus: true,
                            autofillHints: [AutofillHints.password],
                            obscureText: true,
                            cursorColor: const Color(0xf8606163),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Color(0xf8606163)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width:2,
                                  color: Color(0xfff1f2f8),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color(0xfff1f2f8),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: const Color(0xfff1f2f8),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _UpwcheckController,
                            autofocus: true,
                            autofillHints: [AutofillHints.password],
                            obscureText: true,
                            cursorColor: const Color(0xf8606163),
                            decoration: InputDecoration(
                              labelText: 'Password check',
                              labelStyle: const TextStyle(color: Color(0xf8606163)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width:2,
                                  color: Color(0xfff1f2f8),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Color(0xfff1f2f8),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: const Color(0xfff1f2f8),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ),
                      Padding(//login button
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Palette.mainColor,
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            minimumSize: const Size.fromHeight(44),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Sign Up'),
                          onPressed: () async {
                            _singUp();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                        child: RichText(
                          textScaleFactor: MediaQuery.of(context).textScaleFactor,
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text:'Already have account?',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                              TextSpan(
                                text: '  Login',
                                style: const TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xffee8b60),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                                recognizer: TapGestureRecognizer()
                                ..onTap = (){
                                  _logger.i('going to loginpage button clicked');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginPage()),
                                  );
                                },
                              ),
                            ]
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}