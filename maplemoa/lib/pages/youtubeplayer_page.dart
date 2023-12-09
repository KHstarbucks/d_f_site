import 'package:community/providers/youtube.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/material.dart';
import 'package:community/providers/palette.dart';

class YoutubePlayerPage extends StatefulWidget{
  final Id id;
  final Snippet snippet;
  const YoutubePlayerPage({required this.id, required this.snippet});

  @override
  _YoutubePlayerPage createState() => _YoutubePlayerPage();
}

class _YoutubePlayerPage extends State<YoutubePlayerPage> {
  late YoutubePlayerController _controller;
  @override
  void initState(){
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.id.videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
      );
  }

  @override
  Widget build(BuildContext context){
    return YoutubePlayerScaffold(
      controller: _controller,
      aspectRatio: 16/9,
      builder: (context, player){
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.snippet.title,
              style: TextStyle(
                fontSize: 16
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
          body: Column(
            children: [
              player,
              Text(widget.snippet.channelTitle,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        );
      }
    ); 
  }
}