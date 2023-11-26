import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:community/AppState.dart';
import 'dart:async';
import 'home_page.dart';


class LoginPage extends StatefulWidget{
  const LoginPage({Key?key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _UidController = TextEditingController();
  final TextEditingController _UpwController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:'925684634960-ngkhmmc7t04rmnel825rtn6rqhg678q6.apps.googleusercontent.com',
  scopes: <String>[
    'email'
  ]
  );

  Future<UserCredential?> _signInWithEmailAndPw(BuildContext context) async {
    try{
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: _UidController.text,
        password: _UpwController.text,
      );

      final User? user = authResult.user;
      print('Login successfully. ${user?.displayName}');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AppState()),
      );

      return authResult;
    }catch(e){
      print('Login failed. $e');
      return null;
    }
  }


  Future<UserCredential?> _signInWithGoogle(BuildContext context) async {
    try{
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      
      final UserCredential authResult = await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      print("Google Sign In Successful : ${user?.displayName}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AppState()),
      );
      

        return authResult;
      }catch(e){
        print("Google sign in failed: $e");
        return null;
      }
  }

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
                        fontFamily: 'Jua',
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
                      Padding(//login button
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
                          onPressed: () async {
                            await _signInWithEmailAndPw(context);
                          },
                        ),
                      ),
                      Padding(//google login
                        padding: EdgeInsetsDirectional.fromSTEB(0,0,0,16),
                        child: ElevatedButton(
                          child: const Text('Continue with Google'),
                          
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            minimumSize: const Size.fromHeight(44),
                            
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )
                          ),
                          onPressed: ()async{
                            await _signInWithGoogle(context);
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
                                  fontWeight: FontWeight.w400
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

