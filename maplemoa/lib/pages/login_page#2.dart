import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';


class LoginPage extends StatefulWidget{
  const LoginPage({Key?key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _UidController = TextEditingController();
  final TextEditingController _UpwController = TextEditingController();
  
  @override
  void initState(){
    super.initState();
  }
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color(0XFFEE8B60),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
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
                    Text(
                      '메이플모아',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Readex Pro',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
                      child: Text(
                        'Get start with filling out the belows',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:16,
                          fontFamily: 'Readex Pro',
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _UidController,
                            autofocus: true,
                            autofillHints: [AutofillHints.email],
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width:2,
                                  color: Color(0xfff1f2f8),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color(0xfff1f2f8),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _UpwController,
                            autofocus: true,
                            autofillHints: [AutofillHints.password],
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width:2,
                                  color: Color(0xfff1f2f8),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Color(0xfff1f2f8),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Color(0xfff1f2f8),
                            ),
                            
                            keyboardType: TextInputType.text,
                            
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: ElevatedButton(
                          child: const Text('Login'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffee8b60),
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            minimumSize: const Size.fromHeight(44),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: (){
                            
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0,0,0,16),
                        child: ElevatedButton(
                          child: const Text('Continue with Google'),
                          icon: Falcon(
                            FontAwesomeIcons.google,
                            size: 20,
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            minimumSize: const Size.fromHeight(44),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )
                          ),
                          onPressed: ()async{
                            final _googleSignIn = GoogleSignIn();
                            final googleAccount = await _googleSignIn.signIn();

                            if(googleAccount != null){
                              final googleAuth = await googleAccount.authentification;

                              if(googleAuth.accessToken != null &&
                                googleAuth.idToken != null){
                                  try{
                                    await FirebaseAuth.instance.
                                    signInWithCredential(GoogleAuthProvider.credential(
                                      idToken: googleAuth.idToken,
                                      accessToken: googleAuth.accessToken,
                                    ));
                                    print('registered');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute: (builder: (context) => HomePage()),
                                    );
                                  }on FirebaseAuthException catch(e){
                                    print('error occured $e');
                                  }catch(e){
                                    print('error occured $e');
                                  }
                                }else print('error occured $e');
                            }else print('error occured $e');
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                        child: RichText(
                          textScaleFactor: MediaQuery.of(context).textScaleFactor,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:'Don\'t have an account?',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              TextSpan(
                                text: 'Create Account',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xffee8b60),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ]
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
                )
              )
            ),
          ),
        );

  }


  
}

