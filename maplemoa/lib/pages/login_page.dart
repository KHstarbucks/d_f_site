import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert' show json;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:community/auth/authentification.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId:'925684634960-ngkhmmc7t04rmnel825rtn6rqhg678q6.apps.googleusercontent.com',
  scopes: <String>[
    'email'
  ]
);

class LoginPage extends StatefulWidget {
  final VoidCallback onLoginSuccess;
  const LoginPage({Key? key, required this.onLoginSuccess}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignInAccount? _currentUser;
  String _contactText= '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  void initState(){
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState((){
        _currentUser = account;
      });
      if(_currentUser != null){
        _handleGetContact(_currentUser!);
      }
     });
     _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async{
    setState(() {
      _contactText = 'Loading';
    });
    final http.Response response = await http.get(
      Uri.parse(''),
      headers: await user.authHeaders
    );
    if (response.statusCode == 200){
      setState(() {
        _contactText = 'People API gave a ${response.statusCode}'
        'response.Check logs for details';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String,dynamic> data =
    json.decode(response.body) as Map<String,dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if(namedContact != null){
        _contactText = 'I see you know $namedContact';
      }
      else {
        _contactText = 'None';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String,dynamic> data){
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String,dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if(contact != null){
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse:() => null,
      )as Map<String,dynamic>?;
      if(name != null){
      return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async{
    try {
      await _googleSignIn.signIn();
    }catch(e){
      print(e);
    }
  }
  //logout via google sdk
  Future<void> _handleSignOut() =>
   _googleSignIn.signOut();

  Widget _UidWidget(){
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'your email',
      ),
      validator: (String? value){
        if(value!.isEmpty){
          return '이메일을 입력하세요.';
        }
        return null;
      },
    );
  }

  Widget _PwWidget(){
    return TextFormField(
      controller: _pwController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Password',
      ),
      validator: (String? value){
        if(value!.isEmpty){
          return '비밀번호 입력하세요';
        }
        return null;
      }
    );
  }

  Widget _buildBody(){
    final GoogleSignInAccount? user = _currentUser;
    if(user != null){
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(identity: user),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          Text(_contactText),
          ElevatedButton(onPressed: _handleSignOut, child: const Text('Sign out')),
          ElevatedButton(child: const Text('Refresh'),onPressed: ()=> _handleGetContact(user))
        ],
      );
    }
    else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:<Widget>[
          const Text('You are not signed in'),
          ElevatedButton(onPressed: _handleSignIn, child: const Text('Sign in'))
        ]
        );
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFFF8F1EB),
      body: ConstrainedBox(constraints: const BoxConstraints.expand(),
      child: _buildBody(),
      )
    );
  }
}