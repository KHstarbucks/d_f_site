import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community/providers/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MesoPage extends StatefulWidget{
  const MesoPage({Key? key}) : super(key: key);

  @override
  State<MesoPage> createState() => _MesoPageState();
}

class _MesoPageState extends State<MesoPage>{
  final TextEditingController _mesoController = TextEditingController();
  late List<Map<String, dynamic>> mesoComments;
  User? currentUser = FirebaseAuth.instance.currentUser;

  void _addMeso() async{
    String comment = _mesoController.text.trim();
    String author = currentUser?.displayName ?? 'Anonymous';

    if(comment.isNotEmpty){
      await FirebaseFirestore.instance.collection('mesos').add({
        'comment' : comment,
        'author' : author,
        'createdAt' : FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  void initState(){
    super.initState();
    mesoComments = [];
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '메소 거래',
          style: TextStyle(
            fontSize:18,
          ),
        ),
        backgroundColor: Palette.mainColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('mesos').orderBy('createdAt',descending: false).snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Palette.mainColor),
                      ),
                  );
                }
                var mesos = snapshot.data!.docs;

                return ListView.builder(
                  itemCount:  mesos.length,
                  itemBuilder:((context, index) {
                    var mesoData = mesos[index].data() as Map<String, dynamic>;
                    var comment = mesoData['comment'];
                    var author = mesoData['author'];
                    var time = mesoData['createdAt'] as Timestamp;
                    var date = time.toDate();
                    String createdAt = "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";
              
                    return Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xfff7f7f7),
                          boxShadow: const[
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x411d2429),
                              offset: Offset(0,1),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                                    Text(
                                      '$comment'
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 8, 0),
                                      child: AutoSizeText(
                                        '$author',
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '$createdAt',
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Palette.borderColor,
                boxShadow: const [
                  BoxShadow(blurRadius: 3,
                  color: Palette.shadowColor,
                  offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Palette.borderColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                        child: SizedBox(
                          width: 220,
                          child: TextFormField(
                            controller: _mesoController,
                            obscureText: false,
                            decoration: const InputDecoration(
                              labelText: '메소 거래하기',
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
                    IconButton(onPressed: (){
                      _addMeso();
                    },
                    icon: const Icon(Icons.send)
                    )
                  ],
                ),
              ),
            ),
          ),
        ]
      )
    );
  }
}

