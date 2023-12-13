import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:community/providers/palette.dart';

class WritingPage extends StatefulWidget{

  const WritingPage({super.key});

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage>{
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
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
    else{
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('제목, 내용을 채워주세요.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Palette.mainColor,
      ),
      body: Padding(
            padding: const EdgeInsetsDirectional.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _titleController,
                    cursorColor: Palette.cursorColor,
                    decoration: const InputDecoration(
                      labelText: 'content',
                      labelStyle: TextStyle(color: Palette.cursorColor),
                      focusColor: Palette.cursorColor,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width:2,
                          color: Palette.borderColor,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const Divider(
                    color: Palette.cursorColor
                  ),
                  Expanded(
                    child:TextFormField(
                    controller: _contentController,
                    cursorColor: Palette.cursorColor,
                    maxLines: null,
                    expands: true,
                    decoration: const InputDecoration(
                      labelText: 'content',
                      labelStyle: TextStyle(color: Palette.cursorColor),
                      focusColor: Palette.cursorColor,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width:2,
                          color: Palette.borderColor,
                        )
                      )
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  ),
                  const Divider(
                    color: Palette.cursorColor,
                  ),
                ],
              ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addPost();
        },
        backgroundColor: Palette.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Text(
          'Post',
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}