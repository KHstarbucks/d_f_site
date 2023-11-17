import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import'package:community/models/board.dart';

class Board_List with ChangeNotifier {
  final String? authToken;
  List<Board> _items = [];
  Board_List(this.authToken, this._items);

  List<Board> get items {
    return [..._items];
  }

  Future<void> fetchAndSetBoards() async {
    var url =
        'https://dtproject-3930e-default-rtdb.asia-southeast1.firebasedatabase.app/boards.json?auth=$authToken';
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final List<Board> loadedBoards = [];
      extractedData.forEach((boardId, boardData) {
        loadedBoards.add(Board(boardId, boardData['name']));
      });
      _items = loadedBoards;
      print(items);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}