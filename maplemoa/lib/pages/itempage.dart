import 'package:community/pages/itemdetail_page.dart';
import 'package:community/providers/palette.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'itemadd_page.dart';

class ItemPage extends StatefulWidget{
  const ItemPage({Key? key}) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '아이템 거래',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('items').orderBy('createdAt', descending: true).snapshots(),
        builder:(context, snapshot) {
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Palette.mainColor),
              ),
            );
          }
          var itemPosts = snapshot.data!.docs;

          return ListView.builder(
            itemCount: itemPosts.length,
            itemBuilder: (context, index){
              var itemData = itemPosts[index].data() as Map<String, dynamic>;
              var time = itemData['createdAt'] as Timestamp;
              var date = time.toDate();
              String createdAt = "${date.year}.${date.month}.${date.day} ${date.hour}:${date.minute}";
              
              return ListTile(
                contentPadding: const EdgeInsetsDirectional.all(8),
                leading: (itemData['itemPicture'] != null)
                  ?Image.network(itemData['itemPicture'],
                  width: 100,
                  height:100,
                  fit: BoxFit.cover
                  ):const Text(''),
                title: Text(itemData['title']),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${itemData['author']}'),
                    const SizedBox(width: 24),
                    Text(createdAt),
                  ],
                ),
                onTap:() {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ItemDetailPage(item: itemData)));
                },
              );
            }
            
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WritingPage()),
          );
        },
        tooltip: 'Add Post',
        backgroundColor: Palette.mainColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}