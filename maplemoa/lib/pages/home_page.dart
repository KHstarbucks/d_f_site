import 'package:community/providers/mainlistview.dart';
import 'package:flutter/material.dart';
import '/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key:key);

  @override
  State<HomePage> createState() => _HomePageState();

  //Future<List<Post>> getPopularPosts() async {
  //QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //    .collection('posts')
  //    .orderBy('views', descending: true) 
  //    .limit(10)
  //    .get();

  //return querySnapshot.docs.map((doc) {
  //  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //  return Post(
  //    title: data['title'],
  //    content: data['content'],
  //    author: data['author'],
  //    createdAt: data['createdAt'].toDate(),
  //    views: data['views'],
  //    likes: data['likes'],
  //  );
  //}).toList();
 // }

}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: const Text('메이플모아',
            style: TextStyle(
              fontSize:18,
            )
          ),
          backgroundColor: const Color(0xffEE8B60),
        ),
        body: Center(
          child: MyListView()
        ),
    );
  }
}
