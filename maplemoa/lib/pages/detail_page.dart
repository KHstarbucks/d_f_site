import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community/providers/palette.dart';

class DetailPage extends StatefulWidget{
  final Map<String, dynamic> postData;
  final DocumentReference postRef;
  const DetailPage({required this.postData, required this.postRef});

  @override
  State<DetailPage>createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>{
  int likes = 0;
  int dislikes = 0;

  void _updateLikes(DocumentReference postRef, int currentLikes){
    postRef.update({'likes': currentLikes +1});
    setState((){
      likes++;
    });
  }
  void _updateDislikes(DocumentReference postRef, int currentDislikes){
    postRef.update({'dislikes': currentDislikes +1});
    setState(() {
      dislikes++;
    });
  }
  @override
  void initState(){
    super.initState();
    likes = widget.postData['likes'];
    dislikes = widget.postData['dislikes'];
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Palette.mainColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'title',
                style: TextStyle(
                  fontSize:16,
                  fontWeight: FontWeight.w500
                ),
              ),
              const Divider(
                color: Palette.borderColor,
                thickness: 2,
              ),
              Text(
                widget.postData['title'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),
              const Divider(
                color:Palette.borderColor,
                thickness: 2,
              ),
              const Text(
                'content',
                style: TextStyle(
                  fontSize:16,
                  fontWeight: FontWeight.w500
                ),
              ),
              const Divider(
                color:Palette.borderColor,
                thickness: 2,
              ),
              Text(
                widget.postData['content'],
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Ink(
                    decoration: const ShapeDecoration(
                      color: Palette.likesColor,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.thumb_up,
                        size: 20,
                      ),
                      color: Colors.white,
                      onPressed:() {
                        _updateLikes(widget.postRef,widget.postData['likes']);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    (likes - dislikes).toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Ink(
                    decoration: const ShapeDecoration(
                      color: Palette.dislikesColor,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.thumb_down,
                        size:20
                      ),
                      color: Colors.white,
                      onPressed: () {
                        _updateDislikes(widget.postRef, widget.postData['dislikes']);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}