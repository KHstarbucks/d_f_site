import 'package:flutter/material.dart';
import 'package:community/providers/palette.dart';

class ItemDetailPage extends StatelessWidget{
  final Map<String, dynamic> item;

  const ItemDetailPage({required this.item, Key? key}): super(key:key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('${item['title']}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Palette.mainColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('내용'),
            const Divider(
              thickness: 2,
              color: Palette.borderColor,
            ),
            Text(item['content'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Image.network(item['itemPicture']),
            ),
          ],
        ),
      ),
    );
  }
}