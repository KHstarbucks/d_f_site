import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community/providers/palette.dart';
import'package:community/providers/drawer.dart';
import 'detail_page.dart';
import 'boardwriting_page.dart';


class BoardPage extends StatefulWidget{
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage>{

  final TextEditingController _searchController = TextEditingController();
  User? currentUser = FirebaseAuth.instance.currentUser;
  late List<Map<String, dynamic>> searchedPosts;
  
  Future<void> _searchPost(String keyword) async{
    var query = keyword.toLowerCase();
    var querySnapshot = await FirebaseFirestore.instance.collection('posts').
      where('title', isGreaterThanOrEqualTo: query).
      where('title', isLessThan: query + 'z').get();

    setState(() {
      searchedPosts = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  void _updateViews(DocumentReference postRef, int currentViews){
    postRef.update({'views': currentViews +1});
  }
  
  @override
  void initState(){
    super.initState();
    searchedPosts = [];
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: MyDrawer(),
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
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Palette.borderColor,
                boxShadow: const [
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
                padding:const EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                        child: SizedBox(
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
                        //검색
                        _searchPost(_searchController.text);
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //검색결과
          searchedPosts.
          isNotEmpty?Expanded(
            child: ListView.builder(
              itemCount: searchedPosts.length,
              itemBuilder: (context, index) {
                var postData = searchedPosts[index];
                var title = postData['title'];
                var author = postData['author'];
                var date = (postData['createdAt'] as Timestamp).toDate();
                var view = postData['views'];
                String createdAt = "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";

                return Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                  child: GestureDetector(
                      onTap: () {
                        DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc();
                          _updateViews(postRef, view);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailPage(postData: postData, postRef: postRef)),
                          );
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xfff7f7f7),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x411d2429),
                              offset: Offset(0, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 4, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('$title'),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 8, 0),
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
                                  const Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                    child: Icon(
                                      Icons.chevron_right_rounded,
                                      color: Color(0xff57636c),
                                      size: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 4, 8),
                                    child: Text(
                                      createdAt,
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
              ),
            )
            //게시판
          :Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('posts').orderBy('createdAt',descending: true).snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Palette.mainColor),
                    ),
                  );
                }
                var posts = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index){
                    var postData = posts[index].data() as Map<String, dynamic>;
                    var title = postData['title'];
                    var author = postData['author'];
                    var date = (postData['createdAt'] as Timestamp).toDate();
                    var view = postData['views'];
                    String createdAt = "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";

                    return Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                      child: GestureDetector(
                        onTap: (){
                          DocumentReference postRef = FirebaseFirestore.instance.collection('posts').doc(posts[index].id);
                          _updateViews(postRef, view);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailPage(postData: postData, postRef: postRef)),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                          color: const Color(0xfff7f7f7),
                          boxShadow: const [
                            BoxShadow(
                            blurRadius: 3,
                            color: Color(0x411d2429),
                            offset:  Offset(0,1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children:[
                              Expanded(child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 4, 0),
                                child:Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$title'
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 8, 0),
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
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                  child: Icon(
                                    Icons.chevron_right_rounded,
                                    color: Color(0xff57636c),
                                    size: 24,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 4, 8),
                                  child: Text(
                                    createdAt,
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => WritingPage()));
        },
        tooltip: 'Add Post',
        backgroundColor: Palette.mainColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}