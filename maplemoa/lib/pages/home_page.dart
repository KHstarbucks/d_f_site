import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community/providers/youtube.dart';
import 'package:http/http.dart' as http;
import 'package:community/providers/palette.dart';



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
  
  late Future<VideosList> youtubeVideos;
  VideosList? youtube;


  @override
  void initState(){
    super.initState();
    youtubeVideos = fetchYoutubeVideos();
  }
  Future<VideosList> fetchYoutubeVideos() async{
    var part = 'snippet';
    var maxResults = 5;
    var q = '메이플';
    var apiKey = 'AIzaSyCTfzDpAjO2Vs_vlRcvd_Wv3xvvvezcBdc';

    var url = 'https://www.googleapis.com/youtube/v3/search?'
    'part=$part&maxResults=$maxResults&q=$q&type=video&key=$apiKey';

    var response = await http.get(Uri.parse(url));

    //receive
    if(response.statusCode == 200){
      var decodedData = jsonDecode(response.body);
      return VideosList.fromJson(decodedData);
    }
    else{
      throw Exception('Failed to load Youtube videos');
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('메이플모아',
          style: TextStyle(
            fontSize:18,
          )
        ),
        backgroundColor: Palette.mainColor,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
            child: Text(
            'recommended videos',
            style: TextStyle(
              fontSize:18,
              color: Palette.cursorColor,
            ),
          ),
          ),
          FutureBuilder(
            future: youtubeVideos,
            builder: (BuildContext context,AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              else if(snapshot.hasError){
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              else if(!snapshot.hasData || (snapshot.data?.items.isEmpty ?? true)){
                return const Center(child: Text('No videos found.'));
              }
              else{
                return Container(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.items.length,
                    itemBuilder: (context,index){
                      Item item = snapshot.data.items[index];
                      Snippet snippet = item.snippet;
                      return Container(
                        width: 324,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Palette.borderColor,
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.all(8),
                          child:Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width:288,
                                height:162,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Palette.cursorColor,
                                    width: 2,
                                  ),
                                ),
                                child:Image.network(
                                  snippet.thumbnails.medium,
                                  width: double.infinity,
                                  height:double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 12),
                                child: Text(
                                  snippet.channelTitle,
                                  style: const TextStyle(
                                    color: Palette.cursorColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize:16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            }
          ),
        ],
      ),  
    );
  }
}