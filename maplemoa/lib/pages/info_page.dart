import 'package:flutter/material.dart';
import 'package:community/providers/drawer.dart';
import 'package:community/providers/palette.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:logger/logger.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late String imageUrl = '';
  late String serverImgUrl = '';
  late String level = '';
  late String job = '';

  var logger = Logger();
  final TextEditingController _charnameController = TextEditingController();

//tr.search_com_chk > td:nth-child(3)
  Future<void> fetchCharacter(String name) async {
    try{

      final url =
          Uri.parse('https://maplestory.nexon.com/N23Ranking/World/Total?c=$name&w=0');
      final response = await http.get(url);
      logger.d(response);

      if (response.statusCode == 200) {
        var document = html.parse(response.body);
        // 캐릭터 img
        String cssSelector = "tr.search_com_chk > td > span";
        // 서버 img
        String serverSelector = "tr.search_com_chk > td > dl > dt > a";
        //대상 직업
        String jobSelector = "tr.search_com_chk > td > dl";
        //대상 레벨
        String levelSelector = "tr.search_com_chk";

        //캐릭터 추출
        var selectedElement = document.querySelector(cssSelector);
        var image = selectedElement?.children.
        firstWhere((element) => element.localName == 'img');
        var imgUrl = image?.attributes['src'];
        logger.d(imgUrl);

        //서버 마크 추출
        var serverElement = document.querySelector(serverSelector);
        var serverImg = serverElement?.children.
        firstWhere((element) => element.localName == 'img');
        var serverUrl = serverImg?.attributes['src'];
        logger.d(serverUrl);

        //직업 추출
        var jobElement = document.querySelector(jobSelector);
        var jobSource = jobElement?.children.
        firstWhere((element) => element.localName == 'dd');
        var jobName = jobSource?.text;

        //레벨 추출
        var levelElement = document.querySelector(levelSelector);
        logger.d(levelElement);
        var levelSource = levelElement?.children[2];
        var level_ = levelSource?.text;


        logger.d(document.querySelector(serverSelector));
        
        
        if(imgUrl != null && serverUrl != null
        &&level_ != null && jobName != null){
          setState(() {
            imageUrl = imgUrl;
            serverImgUrl = serverUrl;
            job = jobName;
            level = level_;
          });
        }else{
          throw Exception('url not found');
        }
      }
    }catch(e){
      throw Exception('Error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text(
          '캐릭터 정보',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        backgroundColor: Palette.mainColor,
      ),
      body: Center(
        child: Column(
          children: [
            //검색창
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
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: 220,
                          child: TextFormField(
                            controller: _charnameController,
                            decoration: const InputDecoration(
                              labelText: '캐릭터 이름',
                              labelStyle: TextStyle(
                                color: Palette.cursorColor,
                              ),
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
                      IconButton(
                        onPressed:(){
                          fetchCharacter(_charnameController.text.trim());
                        },
                        icon: const Icon(Icons.search),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Palette.borderColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: imageUrl.isNotEmpty?
                      ClipOval(
                        child: Image.network(
                          imageUrl,
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                        )
                      ): const Center(child: Text('영어는 대소문자 구분'))
                    )
                  ),
                  //서버, 닉네임, 레벨
                  serverImgUrl.isNotEmpty?
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(serverImgUrl),
                      Text('${_charnameController.text} | $level'),
                    ],
                  ): const Text(''),
                  //직업
                  job.isNotEmpty?
                  Text(
                    job,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ): const Text(''),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
