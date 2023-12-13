import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:community/providers/youtube.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:community/providers/palette.dart';
import'package:community/providers/drawer.dart';
import 'youtubeplayer_page.dart';
import 'package:community/providers/notice.dart';
import 'notice_page.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  late Future<VideosList> youtubeVideos;
  VideosList? youtube;
  List<Notice> notices = [];


  @override
  void initState(){
    super.initState();
    youtubeVideos = fetchYoutubeVideos();
    getNotice();
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

  Future<void> getNotice() async {
    final url = Uri.parse('https://maplestory.nexon.com/News/Notice');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);
    final titles = html.
    querySelectorAll('p > a > span').
    map((element) => element.innerHtml.trim()).take(10).toList();

    final urls = html.querySelectorAll('p > a').
    map((element) => 'https://maplestory.nexon.com${element.attributes['href']}').take(10).toList();

    setState((){
      notices = List.generate(titles.length, (index) => Notice(
        title: titles[index],
        url: urls[index],
      ));
    });
  }//#container > div > div.contents_wrap > div.qs_text > div > div
  
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: MyDrawer(),
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
              '추천 유튜브 영상',
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
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Palette.mainColor),
                  )
                  );
              }
              else if(snapshot.hasError){
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              else if(!snapshot.hasData || (snapshot.data?.items.isEmpty ?? true)){
                return const Center(child: Text('No videos found.'));
              }
              else{
                return SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.items.length,
                    itemBuilder: (context,index){
                      Item item = snapshot.data.items[index];
                      Snippet snippet = item.snippet;
                      Id id = item.id;
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context) => YoutubePlayerPage(snippet: snippet, id:id))
                          );
                        },
                        child: Container(
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
                        )
                      );
                    },
                  ),
                );
              }
            }
          ),
          const Divider(
            color: Palette.borderColor,
            thickness: 2,
          ),
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
            child: Text(
              '메이플 공지사항',
              style: TextStyle(
                fontSize:18,
                color: Palette.cursorColor,
              ),
            ),
          ),
          //크롤링 결과물
          Expanded(
            child:ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount : notices.length,
              itemBuilder: (context, index){
                final  notice = notices[index];
                return InkWell(
                  onTap: () async {
                    print(notice.url);
                    logger.d(notice.url);
                    try {
                      // NoticePage로 이동
                      print(notices[index]);
                      Navigator.push(context, MaterialPageRoute(builder: ((context) => NoticePage(notice: notice))));
                    } catch (error) {
                      print('Error fetching clicked item HTML: $error');
                    }
                  },
                  child: Text(
                    notice.title,
                    style: const TextStyle(fontSize:16)
                  ),
                );
              }
            ),
          ),
        ],
      ),  
    );
  }
}

