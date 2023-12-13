import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:community/providers/palette.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class WritingPage extends StatefulWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  _WritingPageState createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  File? _selectedImage;

  User? currentUser = FirebaseAuth.instance.currentUser;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = pickedFile != null ? File(pickedFile.path) : null;
    });
  }
  void _addItem() async {
    String title = _titleController.text.trim();
    String content = _contentController.text.trim();
    String author = currentUser?.displayName ?? 'Anonymous';

    if(title.isNotEmpty && content.isNotEmpty){
      if(_selectedImage != null){//사진 업로드 하는 경우
        firebase_storage.Reference storageReference =
          firebase_storage.FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png');
        firebase_storage.UploadTask uploadTask = storageReference.putFile(_selectedImage!);

      await uploadTask.whenComplete(() async {
        // 업로드 완료 후 이미지 URL을 가져와 Firestore에 저장
        String imageUrl = await storageReference.getDownloadURL();

        await FirebaseFirestore.instance.collection('items').add({
          'title': title,
          'content': content,
          'author': author,
          'createdAt': FieldValue.serverTimestamp(),
          'itemPicture': imageUrl,
        });
      });

      }else{//사진 업로드 안하는 경우
        await FirebaseFirestore.instance.collection('items').add({
          'title' : title,
          'content' : content,
          'author' : author,
          'createdAt' : FieldValue.serverTimestamp(),
      });
      }
      
      _titleController.clear();
      _contentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('아이템 거래'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Palette.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 제목 입력란
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '제목',
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
            const Divider(
              thickness: 2,
              color: Palette.deviderColor
            ),
            // 내용 입력란
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: '내용 (최대 5줄)',
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
              maxLines: 5,
            ),
            const Divider(
              thickness: 2,
              color: Palette.deviderColor
            ),
            // 이미지 첨부 버튼 및 선택된 이미지 표시
            IconButton(
              onPressed: _getImage,
              icon: const Icon(
                Icons.collections,
                size: 20
              ),
              alignment: Alignment.bottomLeft,
            ),
            if (_selectedImage != null) ...[
              const SizedBox(height: 8),
              Image.file(
                _selectedImage!,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ],
            // 저장 버튼
            ElevatedButton(
              onPressed: () {
                // 글 저장 로직
                _addItem();
              },
              style:ButtonStyle(
                backgroundColor:MaterialStateProperty.all(Palette.mainColor),
              ),
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
