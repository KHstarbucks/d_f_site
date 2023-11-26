import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'pages/login_page_2.dart';
//import 'pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter());

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: const LoginPage(),
    );
  }
}
