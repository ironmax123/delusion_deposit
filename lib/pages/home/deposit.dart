import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Deposit {
  late List<Map<String, dynamic>> loadedData = [];

  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString('saved_deposit');
    debugPrint('読み込んだデータ: $savedData');

    if (savedData != null) {
      List<dynamic> items = jsonDecode(savedData);
      List<Map<String, dynamic>> data = [];

      for (var item in items) {
        data.add({
          'deposit': item['deposit'],
        });
      }

      loadedData = data;
      debugPrint('読み込み完了: $loadedData');
    } else {
      debugPrint('データが存在しません');
    }
  }

  int get loadInt {
    if (loadedData.isNotEmpty && loadedData[0]['deposit'] is int) {
      return loadedData[0]['deposit'];
    }
    return 0;
  }
}
