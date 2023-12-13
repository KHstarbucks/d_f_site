import 'package:flutter/material.dart';
import 'package:community/providers/notice.dart';
import 'package:community/providers/palette.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:logger/logger.dart';

Logger logger = Logger();

class NoticePage extends StatefulWidget{
  final Notice notice;
  
  const NoticePage({Key? key, required this.notice}) : super(key: key);

  @override 
  State<NoticePage>createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage>{

  List<String> contentList = [];
  String selector = "div.new_board_con > div";


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.notice.title
        ),
        backgroundColor: Palette.mainColor,
        leading:IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: getNotice(widget.notice.url, selector),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError){
                return const Text('Error');
              }
              else{
                return ListView.builder(
                  itemCount: contentList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(contentList[index]),
                    );
                  },
                );
              }
            }else{
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
  Future getNotice(String _url, String _selector) async {
    logger.d(_url);
    try{
      final url = Uri.parse(_url);
      logger.d(url);
      final response = await http.get(url);
    
      if(response.statusCode == 200){
        var document = html.parse(response.body);
        var noticeElement = document.querySelector(selector);
        logger.d(noticeElement?.children);
        var contents = noticeElement?.querySelectorAll('p');
        logger.d(contents);

        if(contents != null){
          contentList = contents.map((element) => element.text).toList();
          
        }
        else{
          throw Exception('not match');
        }
      }
      else{
        throw Exception('server error');
      }
    }catch(e){
      throw Exception(e);
    }
  }
}