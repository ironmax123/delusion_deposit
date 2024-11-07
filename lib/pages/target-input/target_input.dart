import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TargetInput extends HookWidget {
  const TargetInput({super.key});

  @override
  Widget build(BuildContext context) {
    final textFieldValue = useState<int>(0);
    final DayText = useState<String>('');
    final targetText = useState<String>('');

    // データを保存する関数
    Future<void> savetarget() async {
      final prefs = await SharedPreferences.getInstance();

      // 既存の保存データを取得してリストに変換
      String? savedData = prefs.getString('saved_courses');
      List<dynamic> courses = savedData != null ? jsonDecode(savedData) : [];

      // 新しいデータを作成
      final courseData = {
        'target_date': DayText.value, // 目標の日付
        'target_price': textFieldValue.value, // 入力された数値
        'target': targetText.value, // 目的入力
      };

      // 新しいデータを追加して保存
      courses.add(courseData);
      await prefs.setString('saved_data', jsonEncode(courses));
      // 保存完了メッセージ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('情報が保存されました')),
      );
    }

    // 全データを削除する関数
    Future<void> deleteAllData() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('saved_data');
      debugPrint('全データが削除されました');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('目標入力'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) => DayText.value = value,
            decoration: const InputDecoration(
              labelText: '期限を入力してください',
            ),
          ),
          TextField(
            onChanged: (value) => targetText.value = value,
            decoration: const InputDecoration(
              labelText: '目標を入力してください',
            ),
          ),
          TextField(
            onChanged: (value) =>
                textFieldValue.value = int.tryParse(value) ?? 0,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: '金額を入力してください',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await deleteAllData();
              await savetarget();
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }
}
