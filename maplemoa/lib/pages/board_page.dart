import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:community/providers/boards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community/models/post.dart';
import 'package:community/providers/palette.dart';


class BoardPage extends StatefulWidget{
  const BoardPage({Key? key}) : super(key:key);

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage>{

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  bool isWriting = false;
  User? currentUser = FirebaseAuth.instance.currentUser;
  late List<Map<String, dynamic>> searchedPosts;
  
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
  void initState(){
    super.initState();
    searchedPosts = [];
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
          backgroundColor: Palette.mainColor,
      ),
      body: Column(
        children: [
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Palette.borderColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Palette.shadowColor,
                    offset: Offset(0,2),
                  ),
                ],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Palette.borderColor,
                ),
              ),
              child: Padding(
                padding:EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                        child: Container(
                          width: 220,
                          child: TextFormField(
                            controller: _searchController,
                            obscureText: false,
                            decoration: const InputDecoration(
                              labelText: 'search..',
                              labelStyle: TextStyle(color: Palette.cursorColor),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              filled: true,
                              fillColor: Palette.borderColor,
                            ),
                            keyboardType: TextInputType.text,
                            cursorColor: Palette.cursorColor,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        print(" s");
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //board list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var posts = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index){
                    var postData = posts[index].data() as Map<String, dynamic>;
                    var title = postData['title'];
                    var author = postData['author'];
                    var createdAt = (postData['createdAt'] as Timestamp).toDate();

                    return Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                      child: GestureDetector(
                        onTap: (){
                          print('$index tapped');
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                          color: Color(0xfff7f7f7),
                          boxShadow: [
                            BoxShadow(
                            blurRadius: 3,
                            color: Color(0x411d2429),
                            offset:  Offset(0,1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children:[
                              Expanded(child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(8, 8, 4, 0),
                                child:Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$title'
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 8, 0),
                                      child: AutoSizeText(
                                        '$author',
                                        textAlign: TextAlign.start,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                  child: Icon(
                                    Icons.chevron_right_rounded,
                                    color: Color(0xff57636c),
                                    size: 24,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 4, 8),
                                  child: Text(
                                    '$createdAt',
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),  
                  ),
                );
              },
            );
          },
          )
        ),//글 작성을 위한 버튼을 누른 경우
        isWriting 
        ? Container(
            height: 400,
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'title',
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: _contentController,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: 'content',
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _addPost, 
                  child: Text('Post'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffee8b60),
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    minimumSize: const Size.fromHeight(8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ): Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isWriting = true;
          });
        },
        tooltip: 'Add Post',
        backgroundColor: Palette.mainColor,
        child: Icon(Icons.add),
      ),
    );
  }
}