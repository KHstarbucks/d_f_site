import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:community/providers/boards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community/models/post.dart';


class BoardPage extends StatefulWidget{
  const BoardPage({Key? key}) : super(key:key);

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage>{

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool isWriting = false;
  User? currentUser = FirebaseAuth.instance.currentUser;
  
  //add new post
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

      setState(() {
        isWriting = false;
      });
    }
  }
  void _updateViews(DocumentReference postRef, int currentViews){
    postRef.update({'views': currentViews +1});
  }
  void _updateLikes(DocumentReference postRef, int currentLikes){
    postRef.update({'likes': currentLikes +1});
  }
  void _updateDislikes(DocumentReference postRef, int currentDislikes){
    postRef.update({'dislikes': currentDislikes +1});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: const Text('자유 게시판',
            style: TextStyle(
              fontSize:18,
            )
          ),
          backgroundColor: const Color(0xffEE8B60),
      ),
      body: Column(
        children: [
          //board list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var posts = snapshot.data!.docs;
                List<Widget> postWidgets = [];
                for(var post in posts){
                  var postData = post.data() as Map<String, dynamic>;
                  var title = postData['title'];
                  var content = postData['content'];
                  var author = postData['author'];
                  var views = postData['views'];
                  var likes = postData['likes'];
                  var dislikes = postData['dislikes'];
                  var createdAt = (postData['createdAt'] as Timestamp).toDate();

                  var postWidget = ListTile(
                    title: Text(title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(content),
                        Text('Author: $author'),
                        Text('Likes: $likes'),
                        Text('Dislikes: $dislikes'),
                        Text('Created At: ${createdAt.toString()}'),
                      ],
                    ),
                    onTap: (){
                      _updateViews(post.reference, views);
                    }
                  );
                  postWidgets.add(postWidget);
                }
                return ListView(
                  children: postWidgets,
                );
              }
            ),
          ),
          isWriting ? Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: 'title',
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _contentController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'content',
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(onPressed: _addPost, child: Text('Post'))
              ],
            ),
          ): Container(),
        ],
      ),//posting button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isWriting = true;
          });
        },
        tooltip: 'Add Post',
        child: Icon(Icons.add),
        backgroundColor: const Color(0xffee8b60),
      ),
    );
  }
}