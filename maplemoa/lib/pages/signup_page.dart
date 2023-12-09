import 'package:community/providers/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'login_page_2.dart';

class SignupPage extends StatelessWidget{
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _uidController = TextEditingController();
  final TextEditingController _upwController = TextEditingController();
  final TextEditingController _upwcheckController = TextEditingController();
  
  final Logger _logger = Logger();

  SignupPage({super.key});

  void _singUp() async {
    String uname = _nameController.text;
    String id = _uidController.text;
    String pw = _upwController.text;
    String pwcheck = _upwController.text;

    if(pw == pwcheck){
      try{
        //firebaseauth에 id,pw저장
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: id,
          password: pw
          );
          FirebaseAuth.instance.currentUser?.updateDisplayName(uname);
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
        backgroundColor: Palette.mainColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                maxWidth: 570,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow:const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Palette.shadowColor,
                    offset: Offset(0,2),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Align(
                alignment: const AlignmentDirectional(0,0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
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
                            controller: _nameController,
                            autofocus: true,
                            autofillHints: const [AutofillHints.name],
                            obscureText: false,
                            cursorColor: Palette.cursorColor,
                            decoration: InputDecoration(
                              labelText: 'Nickname',
                              labelStyle: const TextStyle(color: Palette.cursorColor),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width:2,
                                  color: Palette.borderColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Palette.borderColor,
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
                              fillColor: Palette.borderColor,
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
                            controller: _uidController,
                            autofocus: true,
                            autofillHints: const [AutofillHints.email],
                            obscureText: false,
                            cursorColor: Palette.cursorColor,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: const TextStyle(color: Color(0xf8606163)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width:2,
                                  color: Palette.borderColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Palette.borderColor,
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
                              fillColor: Palette.borderColor,
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
                            controller: _upwController,
                            autofocus: true,
                            autofillHints: const [AutofillHints.password],
                            obscureText: true,
                            cursorColor: Palette.cursorColor,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Color(0xf8606163)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width:2,
                                  color: Palette.borderColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Palette.borderColor,
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
                              fillColor: Palette.borderColor,
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
                            controller: _upwcheckController,
                            autofocus: true,
                            autofillHints: const [AutofillHints.password],
                            obscureText: true,
                            cursorColor: Palette.cursorColor,
                            decoration: InputDecoration(
                              labelText: 'Password check',
                              labelStyle: const TextStyle(color: Color(0xf8606163)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width:2,
                                  color: Palette.borderColor,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Palette.borderColor,
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
                              fillColor: Palette.borderColor,
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
                                  color: Palette.mainColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                                recognizer: TapGestureRecognizer()
                                ..onTap = (){
                                  _logger.i('going to loginpage button clicked');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginPage()),
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