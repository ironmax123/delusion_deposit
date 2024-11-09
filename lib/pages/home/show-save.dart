import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowSave {
  // ValueNotifierを使って状態を管理する
  List<Map<String, dynamic>> loadedData = [];

  // データを読み込む非同期メソッド
  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString('saved_data');
    debugPrint('読み込んだデータ: $savedData');

    if (savedData != null) {
      List<dynamic> items = jsonDecode(savedData);
      List<Map<String, dynamic>> data = [];

      for (var item in items) {
        if (item.containsKey('target_date') &&
            item.containsKey('target_price') &&
            item.containsKey('target')) {
          data.add({
            'target_date': item['target_date'] ?? '不明な日付',
            'target_price': item['target_price'] ?? 0,
            'target': item['target'] ?? '不明な目標'
          });
        }
      }

      loadedData = data;
      debugPrint('読み込み完了: $loadedData');
    } else {
      debugPrint('データが存在しません');
    }
  }
}
