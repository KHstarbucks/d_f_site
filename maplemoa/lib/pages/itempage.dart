import 'package:community/providers/palette.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemPage extends StatefulWidget{
  const ItemPage({Key? key}) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage>{

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
        stream: FirebaseFirestore.instance.collection('itemPosts').orderBy('createdAt', descending: true).snapshots(),
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
              
            }
            
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          
        },
        tooltip: 'Add Post',
        backgroundColor: Palette.mainColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}