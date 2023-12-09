import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:community/providers/palette.dart';
import'package:community/providers/drawer.dart';

class UnionPage extends StatefulWidget{
  const UnionPage({super.key});
  
  @override
  State<UnionPage> createState() => _UnionPageState();
}

class _UnionPageState extends State<UnionPage>{
  //레벨
  late final WebViewController _controller;

  @override
  void initState(){
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if(WebViewPlatform.instance is WebKitWebViewPlatform){
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    }else{
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);

    controller
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Palette.borderColor)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: ((progress) {
          print('progress : $progress%');
        }),
        onPageStarted: (url) {
          print('loading $url');
        },
        onPageFinished: (url) {
          print('$url finished');
        },
        onNavigationRequest: (request) {
          print('navigate to ${request.url}');
          return NavigationDecision.navigate;
        },
      )
    )..addJavaScriptChannel(
      'channel',
      onMessageReceived: (JavaScriptMessage message){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      }
    )..loadRequest(Uri.parse('https://xenogents.github.io/LegionSolver/'));

    if(controller.platform is AndroidWebViewController){
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text('유니온 배치',
          style: TextStyle(
            fontSize:18,
          )
        ),
        backgroundColor:Palette.mainColor,
      ),
      body: SafeArea(
        bottom: false,
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}