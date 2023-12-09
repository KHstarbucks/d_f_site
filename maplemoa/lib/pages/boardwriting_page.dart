import 'package:firebase_core_web/firebase_core_web_interop.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WritingPage extends StatefulWidget{

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage>{
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  User? currentUser =FirebaseAuth.instance.currentUser;

  void _addPost() async {
    String title = _titleController.text.trim();
    String content = _contentController.text.trim();
    String author = currentUser?.displayName ?? 'Anonymous';

    if(title.isNotEmpty && content.isNotEmpty){
      await FirebaseFirestore.instance.collection('posts').add({
        'title' : title,
        'content' : content,
        'author' : author,
        'views' : 0,
        'likes' : 0,
        'dislikes' : 0,
        'createdAt' : FieldValue.serverTimestamp(),
      });

      _titleController.clear();
      _contentController.clear();
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Posting',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
          child: Container(
            width: double.infinity,
            
          ),
        ),
      ),
    );
  }
}