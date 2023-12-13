import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:community/providers/palette.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  _WritingPageState createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  File? _selectedImage;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('아이템 거래'),
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
            ElevatedButton(
              onPressed: _getImage,
              child: const Text('이미지 첨부'),
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
            const Spacer(),
            // 저장 버튼
            ElevatedButton(
              onPressed: () {
                // 글 저장 로직 추가
                // _titleController.text에 제목, _contentController.text에 내용
                // _selectedImage에 선택된 이미지 파일
              },
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
