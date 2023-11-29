import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:community/AppState.dart';
import 'dart:async';
import 'signup_page.dart';


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

      Future.delayed(Duration.zero, (){
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AppState()),
        );
      });

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
      Future.delayed(Duration.zero, (){
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AppState()),
        );
      });
      

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
          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
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
                  color: const Color(0X33000000),
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
                      'Maple Moa',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
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
                      Padding(//login button
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffee8b60),
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            minimumSize: const Size.fromHeight(44),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Login'),
                          onPressed: () async {
                            await _signInWithEmailAndPw(context);
                          },
                        ),
                      ),
                      Padding(//google login
                        padding: const EdgeInsetsDirectional.fromSTEB(0,0,0,16),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            minimumSize: const Size.fromHeight(44),
                            side: const BorderSide(color: Color(0xffee8b60)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              
                            )
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                FontAwesomeIcons.google,
                                size: 20,
                                color: Color(0xffee8b60),
                              ),
                              Text(
                            ' Continue with Google',
                            style: TextStyle(
                              color: Color(0xffee8b60),
                                ),  
                              ),
                              
                            ],
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
                              const TextSpan(
                                text:'Don\'t have an account?',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                              TextSpan(
                                text: '  Create Account',
                                style: const TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Color(0xffee8b60),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                                recognizer: TapGestureRecognizer()
                                ..onTap = (){
                                  print("clicked");
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => SignupPage()),
                                  );
                                },
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

